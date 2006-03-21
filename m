Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965143AbWCUW71@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965143AbWCUW71 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 17:59:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965141AbWCUW71
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 17:59:27 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:37544 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S965140AbWCUW7Z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 17:59:25 -0500
Date: Tue, 21 Mar 2006 22:59:21 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Phillip Lougher <phillip@lougher.demon.co.uk>, Pavel Machek <pavel@ucw.cz>,
       Phillip Lougher <phillip@lougher.org.uk>,
       "unlisted-recipients: no To-header on input <;, Jeff Garzik" 
	<jeff@garzik.org>,
       J?rn Engel <joern@wohnheim.fh-wedel.de>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
Subject: Re: [ANN] Squashfs 3.0 released
Message-ID: <20060321225921.GJ27946@ftp.linux.org.uk>
References: <0E3DADA8-1A1C-47C5-A3CF-F6A85FF5AFB8@lougher.org.uk> <441AF118.7000902@garzik.org> <20060319163249.GA3856@ucw.cz> <4420236F.80608@lougher.demon.co.uk> <20060321161452.GG27946@ftp.linux.org.uk> <44204F25.4090403@lougher.org.uk> <20060321191144.GB3929@elf.ucw.cz> <44205C1A.4040408@lougher.demon.co.uk> <20060321200750.GH27946@ftp.linux.org.uk> <Pine.LNX.4.61.0603212301160.24534@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0603212301160.24534@yvahk01.tjqt.qr>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 21, 2006 at 11:01:58PM +0100, Jan Engelhardt wrote:
> >
> >You mean, like IP?  Or NFS?  Or XFS?  Or any number of other big-endian
> >data layouts?  Make it fixed to big-endian - no problem with that...
> >
> And most machines are little endian. So statistically, the world swapped 
> more than it would have to.

... and on most of them that costs how many cycles, again?  How much do
test and branch cost?

That is not to mention boxen with instructions along the lines of
load-and-swap/swap-and-store...
