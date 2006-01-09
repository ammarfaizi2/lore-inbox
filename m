Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964886AbWAIR2S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964886AbWAIR2S (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 12:28:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964888AbWAIR2S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 12:28:18 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:53379 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S964883AbWAIR2R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 12:28:17 -0500
Subject: Re: Why the DOS has many ntfs read and write driver,but the linux
	can't for a long time
From: Lee Revell <rlrevell@joe-job.com>
To: Olivier Galibert <galibert@pobox.com>
Cc: Oliver Neukum <oliver@neukum.org>, Bernd Petrovitsch <bernd@firmix.at>,
       Robert Hancock <hancockr@shaw.ca>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20060109171411.GB67773@dspnet.fr.eu.org>
References: <5t06S-7nB-15@gated-at.bofh.it>
	 <1136824149.5785.75.camel@tara.firmix.at>
	 <1136824880.9957.55.camel@mindpipe> <200601091753.36485.oliver@neukum.org>
	 <20060109171411.GB67773@dspnet.fr.eu.org>
Content-Type: text/plain
Date: Mon, 09 Jan 2006 12:28:14 -0500
Message-Id: <1136827695.9957.73.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-01-09 at 18:14 +0100, Olivier Galibert wrote:
> On Mon, Jan 09, 2006 at 05:53:35PM +0100, Oliver Neukum wrote:
> > Does the Windows Explorer draw icons based only on name and metadata?
> 
> >From what I can see it does icons on non-executable entirely based on
> the extension and nothing else on the first pass.  Executables are
> looked inside for an icon (and there seems to be cache effects at
> times, especially visible on the desktop).  Then for images a second
> pass generates icons depending on the contents (with, once again, a
> cache hidden somewhere).
> 
> Not a bad strategy, too.  Doing a file(1) on everything can only be
> slow given the random disk accesses it generates.  Maybe a file(1) as
> a _second_ pass would work.

Gack, does Nautilus really do file(1) on everything?  That's unspeakably
awful.

Lee

