Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265117AbTLRLyE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Dec 2003 06:54:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265127AbTLRLyE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Dec 2003 06:54:04 -0500
Received: from intra.cyclades.com ([64.186.161.6]:40662 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S265117AbTLRLx7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Dec 2003 06:53:59 -0500
Date: Thu, 18 Dec 2003 09:47:42 -0200 (BRST)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: Arnaud Fontaine <arnaud@andesi.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Oops with 2.4.23
In-Reply-To: <20031218085621.GA8283@scrappy>
Message-ID: <Pine.LNX.4.44.0312180946550.4547-100000@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cyclades-MailScanner-Information: Please contact the ISP for more information
X-Cyclades-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 18 Dec 2003, Arnaud Fontaine wrote:

> Hello,
> 
> I am using 2.4.23 kernel with no patchset. It was the first time i
> install a linux distribution on this PC, so i can't tell you if it have
> this Oops with an another version of the kernel. It looks to work fine 
> during 1 or 2 days until i have an weird Oops. I have rebooted the machine 
> after this but it appears again few days later and despite some reboot.
> 
> I haven't include the support for module loadable. I am using Debian
> GNU/Linux Woody up to date.


Andrew, 

This is likely to be bad memory.

Can you try memtest86 on the box ? 

> Thanks for you help.
> Arnaud Fontaine
> 
> -------------- ksymoops
>  <1>Unable to handle kernel NULL pointer dereference at virtual address
> 00000000
> c0138ff2
> *pde = 00000000
> Oops: 0000
> CPU:    0
> EIP:    0010:[vfs_follow_link+26/332]    Not tainted
> EFLAGS: 00010217
> eax: 00000000   ebx: caaf5f8c   ecx: cba98288   edx: caaf5f8c
> esi: 00000000   edi: 00000000   ebp: cbafc0e0   esp: caaf5ee4
> ds: 0018   es: 0018   ss: 0018
> Process ps (pid: 800, stackpage=caaf5000)
> Stack: caa3dc40 caaf4000 caaf5f8c cbafc0e0 c014add7 caaf5f8c 00000000
> c0136dea 
>        caa3dc40 caaf5f8c cbafc0e0 caaf5f8c cb57d000 00000000 00000001
> 00000001 
>        00000001 cb57d00d caa3dc40 cb57d006 00000007 08733bbe c0136f56
> c01370c7 
> Call Trace:    [proc_follow_link+27/32] [link_path_walk+1794/2132]
> [path_walk+26/28] [path_lookup+27/36] [open_namei+101/1244]
> Code: 80 3e 2f 0f 85 a5 00 00 00 53 e8 b7 d4 ff ff ba 00 e0 ff ff 
> 
> 
> >>ebx; caaf5f8c <END_OF_CODE+a840894/????>
> >>ecx; cba98288 <END_OF_CODE+b7e2b90/????>
> >>edx; caaf5f8c <END_OF_CODE+a840894/????>
> >>ebp; cbafc0e0 <END_OF_CODE+b8469e8/????>
> >>esp; caaf5ee4 <END_OF_CODE+a8407ec/????>
> 

