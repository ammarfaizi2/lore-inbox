Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130236AbRCCDQg>; Fri, 2 Mar 2001 22:16:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130240AbRCCDQ0>; Fri, 2 Mar 2001 22:16:26 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.29]:34575 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S130239AbRCCDQO>; Fri, 2 Mar 2001 22:16:14 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Jasmeet Sidhu <jsidhu@arraycomm.com>
Date: Sat, 3 Mar 2001 14:15:45 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15008.25057.125077.93516@notabene.cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org (Linux Kernel)
Subject: Re: Linux 2.4.2-ac5 IDE Software Raid(ata/100) Problem..Kernel
  Oops?
In-Reply-To: message from Jasmeet Sidhu on Friday March 2
In-Reply-To: <5.0.2.1.2.20010302135432.00af8ae0@pop.arraycomm.com>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday March 2, jsidhu@arraycomm.com wrote:
> 1. Problem description
> 2. Machine details
> 	a) Hardware
> 	b) Software
> 3. System log during the incident
> 
> 1. Problem Description:
> 
snip
> Mar  2 13:44:38 bertha kernel: Unable to handle kernel NULL pointer 
> dereference at virtual address 00000038
> Mar  2 13:44:38 bertha kernel:  printing eip:
> Mar  2 13:44:38 bertha kernel: c01ed5ee
> Mar  2 13:44:38 bertha kernel: *pde = 00000000
> Mar  2 13:44:38 bertha kernel: Oops: 0000
> Mar  2 13:44:38 bertha kernel: CPU:    0
> Mar  2 13:44:38 bertha kernel: EIP:    0010:[raid5_diskop+910/1520]
snip
> 		Using Linux Kernel 2.4.2-ac5

Fixed in 2.4.2-ac6

NeilBrown
