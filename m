Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269853AbUJMVfc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269853AbUJMVfc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Oct 2004 17:35:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269858AbUJMVfb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Oct 2004 17:35:31 -0400
Received: from mailhost.tue.nl ([131.155.2.7]:4366 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S269853AbUJMVfW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Oct 2004 17:35:22 -0400
Date: Wed, 13 Oct 2004 23:35:19 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.6.8 Hates DOS partitions
Message-ID: <20041013213519.GA3379@pclin040.win.tue.nl>
References: <Pine.LNX.4.61.0410131329110.3818@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0410131329110.3818@chaos.analogic.com>
User-Agent: Mutt/1.4.1i
X-Spam-DCC: : 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 13, 2004 at 01:31:34PM -0400, Richard B. Johnson wrote:

> Only the DOS partitions and the swap are used in this new configuration.
> This is a new "Fedora Linux 2" installation on a completely
> different IDE hard disk, in which I have to enable boot disks in
> the BIOS to boot the new system.
> 
> Immediately after installing the new system I reverted (in the BIOS)
> to the original to make sure that I was still able to boot the old
> system and the DOS partition. Everything was fine.
> 
> Then I installed linux-2.6.8 after building a new kernel with
> the old ".config" file used as `make oldconfig`. Everything was
> fine after that, also.
> 
> I have now run for about a week and I can't boot the DOS partition
> anymore!
> 
> I can copy everything  from C: and D: from within Linux
> and then re-do the DOS partitions, BUT.... bad stuff
> will happen again unless the cause is found.

Well, if you do and the same thing happens, we know that there is something
reproducible here. That is always good to know. It might be that you did
something a week ago and forgot all about it and now have a strange bug.

If this is reproducible, then there are lots of possible explanations.

Have you considered the numbering of the disks? You changed things in
the BIOS. Did the Linux SCSI disk numbering remain the same?

Andries
