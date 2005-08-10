Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965109AbVHJNdp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965109AbVHJNdp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 09:33:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965110AbVHJNdp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 09:33:45 -0400
Received: from mail43.e.nsc.no ([193.213.115.43]:42140 "EHLO mail43.e.nsc.no")
	by vger.kernel.org with ESMTP id S965109AbVHJNdp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 09:33:45 -0400
Date: Wed, 10 Aug 2005 15:33:42 +0200
To: linux-kernel@vger.kernel.org
Subject: captive-ntfs FUSE support?
From: Kristoffer <kfs1@online.no>
Content-Type: text/plain; charset=US-ASCII;
	format=flowed	delsp=yes
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-ID: <op.svanygid3czpo8@myhost.localdomain>
User-Agent: Opera M2/8.01 (Linux, build 1204)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

captive ntfs: http://www.jankratochvil.net/project/captive/
http://www.jankratochvil.net/project/captive/CVS.html.pl

Can someone please port cvs captive-ntfs to FUSE?

why?:
Since LUFS is no longer maintained and FUSE is. since to use the LUFIS  
bridge you have to install LUFS, which doesn't go into the kernel anymore  
because it's no longer maintained, and if you did get it to go into the  
kernel it's much more trouble than the LUFS syntax for mounting,etc. And  
LUFS-only doesn't go into the kernel as said. Since gnome-vfs2 doesn't  
work on / dir because of a bug. Since i want the CVS version of captive,  
but i can't get it to compile. Since this is the only working  
non-commercial solution to getting NTFS read/write in linux. Since the  
developer isn't going to implement it(from his mailing list):

# ...
# > I was wondering about the status of captive, is it totally dead?
#
# Yes, before someone writes acceptable Free kernel and before I start to  
make
# some financial income on Captive again.
#
#
# > If not, is there any work being done on actually porting it to fuse by  
anyone?
#
# No. And definitely not by myself as FUSE is Linux kernel bound while the  
Linux
# kernel itself is broken by design and therefore even FUSE is broken by  
design.
#
# BTW the FUSE frontend is really a trivia piece of code, its LUFS  
counterpart is
# 30KB after "sort -u". It would be a part of one evening to code it  
myself but
# it is more a psychological fun for me to watch the Famous Free Software
# Community unable to code this tiny trivia bit of glue to run the wanted
# project. This glue is required just because of LUFS is no longer  
supported and
# LUFS would need to be ported each day according to the mood of the Linux  
kernel
# "developers" - this other part of the Famous Free Software Community  
f*cks up
# the ABI+API of each Linux kernel release themselves and thus turning  
down all
# the people around who still belive that crap could be used for anything.  
Really
# funny. Unfortunately there is still nothing much better available out  
there.

And other more practical reasons for the ones who doesn't code on the  
linux kernel for hobby/profit and nor is a programmer. I would implement  
it myself if i knew how to code, but since i can't i'm asking you.

I'm not signed-up to this list(too much mail) but am following the  
newslist mirror. Please do CC your reply/comments to me though.

Thank you.
- KSF
