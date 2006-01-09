Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964888AbWAIReE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964888AbWAIReE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 12:34:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964889AbWAIReD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 12:34:03 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:12677 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S964888AbWAIReC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 12:34:02 -0500
Subject: Re: Why the DOS has many ntfs read and write driver,but the linux
	can't for a long time
From: Lee Revell <rlrevell@joe-job.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Oliver Neukum <oliver@neukum.org>, Bernd Petrovitsch <bernd@firmix.at>,
       Robert Hancock <hancockr@shaw.ca>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1136827900.6659.66.camel@localhost.localdomain>
References: <5t06S-7nB-15@gated-at.bofh.it>
	 <1136824149.5785.75.camel@tara.firmix.at>
	 <1136824880.9957.55.camel@mindpipe>  <200601091753.36485.oliver@neukum.org>
	 <1136827900.6659.66.camel@localhost.localdomain>
Content-Type: text/plain
Date: Mon, 09 Jan 2006 12:33:59 -0500
Message-Id: <1136828040.9957.79.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-01-09 at 17:31 +0000, Alan Cox wrote:
> On Llu, 2006-01-09 at 17:53 +0100, Oliver Neukum wrote:
> > Does the Windows Explorer draw icons based only on name and metadata?
> 
> Sort of. It also plays tricks on the human by working out what icons are
> visible and loading those first then filling in while the user thinks it
> is ready
> 

See, I don't think that's a trick, isn't it just a form of demand
paging?  It seems silly to make the user wait to see the visible icons
until it's done rendering the hidden stuff.  Otherwise navigating the
file system speeds up and slows down based on how many files are in each
directory, even if the number of visible icons remains constant.

Do most Linux GUI apps really render everything without regard to what's
obscured and what's visible?

Lee

