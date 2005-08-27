Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030338AbVH0IKT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030338AbVH0IKT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Aug 2005 04:10:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030341AbVH0IKS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Aug 2005 04:10:18 -0400
Received: from ms-smtp-02-smtplb.rdc-nyc.rr.com ([24.29.109.6]:2219 "EHLO
	ms-smtp-02.rdc-nyc.rr.com") by vger.kernel.org with ESMTP
	id S1030338AbVH0IKR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Aug 2005 04:10:17 -0400
Date: Sat, 27 Aug 2005 08:19:18 +0000
From: Kent Robotti <dwilson24@nyc.rr.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Initramfs and TMPFS!
Message-ID: <20050827081918.GA963@Linux.nyc.rr.com>
Reply-To: dwilson24@nyc.rr.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   On Fri Aug 26 2005 - 05:33:43 EST, Erik Mouw wrote:
   > I prefer tar because I have more experience with it, and it works.
   >> The kernel people prefer cpio because they have experience with it, it
   >> doesn't need too much code, and it works.
   
I know that experience dosen't come from packing the kernel source,
or the zillion other tar archives on the internet.
   
   > It seems to be the most used archiver in the UNIX world.
   >> You've been told that there are *technical* reasons not to use tar in
   >> the kernel. The kernel developers never cared about what was most used
   >> or what "the market wants", but only about what was *technically*
   >> useful.

I haven't been told that.
   
   >>Did you ever take some time to actually *understand* what ramfs is,
   >>*why* it is used for initramfs, and why you can't use any filesystem
   >>you like for an initramfs?
   
You can use tmpfs and that's sufficient.

You only need one initramfs and it should be tmpfs, but if you
have two make ramfs a little more robust (that word again!).

This is a definition of robust I found on the web:
   Refers to software without bugs that handles abnormal conditions well.
   It is often  said that there is no software package totally bug free.
   Any program can exhibit odd behavior under certain conditions, but a
   robust program will not *lock up* the computer, cause damage to data or
   send the user through an endless chain of dialog boxes without
   purpose.  Whether or not a program can be totally bug free will be
   debated forever.

I'm sure if I gave ramfs a chance it would fit that definition to a tee.
    
   > For one, if you do "dd if=/dev/zero of=foo" on a ramfs the system
   > will lock up.
   >> "Doctor, it hurts when I do this!" "Well, then don't do that."
   >> You found a nice case of "Unix, rope, foot".

I guess you graduated from the Henny Youngman school of coding, the same
school the author of ramfs graduated from.

But seriously, you're obviously a coder/comedian and I hope you don't
confuse the two.

If Windows had that defeatest philosophy where would it be?

Ramfs has a more limited use than tmpfs and that may be sufficient,
because people know its limitations and stay within them, but
that's no reason to pat yourself on the back.

   >>PS: I'm not going to hunt through my linux-kernel mailbox for replies
   >>without proper In-Reply-To and References headers in the hope that I
   >>stumble over a possible reply from you. Any reply without such
   >>headers will most probably not been seen and just ignored.
   
You have to Cc me if you want that.
