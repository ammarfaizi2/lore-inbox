Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261411AbREYSG5>; Fri, 25 May 2001 14:06:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261404AbREYSGh>; Fri, 25 May 2001 14:06:37 -0400
Received: from [63.109.146.2] ([63.109.146.2]:37873 "EHLO mail0.myrio.com")
	by vger.kernel.org with ESMTP id <S261401AbREYSGZ>;
	Fri, 25 May 2001 14:06:25 -0400
Message-ID: <B65FF72654C9F944A02CF9CC22034CE22E1BD4@mail0.myrio.com>
From: Torrey Hoffman <torrey.hoffman@myrio.com>
To: "'Adam J. Richter'" <adam@yggdrasil.com>
Cc: linux-kernel@vger.kernel.org
Subject: RE: Fwd: Copyright infringement in linux/drivers/usb/serial/keysp
	an*fw.h
Date: Fri, 25 May 2001 11:06:15 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Adam J. Richter wrote:
> Doug Ledford wrote:
> >"Adam J. Richter" wrote:
> 
> >>         On the question of whether this is nothing more than
> >> aggregation,

... 
[patent law definition of aggregation]
...

Well, I'm just an interested bystander.  But having read the recent 
lkml posts on this issue, it seems to me that the critical points are:

>From the point of view of the kernel, the firmware code is just a big
magic number that "turns on" the firmware.  

The kernel is not _linked_ _with_ the firmware code.

The kernel doesn't even _exec_ the firmware.

The firmware code can be used, unmodified, in other operating systems.

The firmware code does not run in the same address space as the kernel.

In principle, and maybe in practice, that firmware code might be running
on a different processor, with different RAM, and a different instruction
set.  

It's obviously not part of the kernel! 

Torrey Hoffman  -  torrey.hoffman@myrio.com
-------------------------------------------
I find this corpse guilty of carrying a concealed weapon and I fine it $40. 
-- Judge Roy Bean, finding a pistol and $40 on a man he'd just shot. 
