Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132045AbRDPU0B>; Mon, 16 Apr 2001 16:26:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132046AbRDPUZm>; Mon, 16 Apr 2001 16:25:42 -0400
Received: from adsl-63-195-162-81.dsl.snfc21.pacbell.net ([63.195.162.81]:62472
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S132045AbRDPUZj>; Mon, 16 Apr 2001 16:25:39 -0400
Date: Mon, 16 Apr 2001 13:25:32 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Mickey Lalescu <mickey@personus.com>
cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.3 VFS bug and namei.c bug
In-Reply-To: <8E2EEEE24B6FD211ADC400104B71BA020169DB4A@MESSAGING>
Message-ID: <Pine.LNX.4.10.10104161325100.19043-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


dev 08:01

This is a SCSI device sorry...

On Mon, 16 Apr 2001, Mickey Lalescu wrote:

> I am not sure if this is an IDE problem it seems to be an VFS one but I
> can't find the maintainer for VFS. Ouch while I was trying to submit this
> other bug I've got another one. Here is the output of the new one
>  
> I/O error: dev 08:01, sector 67080
> kernel BUG at namei.c:343!
> invalid operand: 0000
> CPU:    0
> EIP:    0010:[<c0170585>]
> EFLAGS: 00010282
> eax: 0000001b   ebx: cb8efe68   ecx: c4de6000   edx: c02c7f68
> esi: c393a660   edi: cb8efea8   ebp: cb8efe0c   esp: cb8efe00
> ds: 0018   es: 0018   ss: 0018
> Process man (pid: 415, stackpage=cb8ef000)
> Stack: c0276e8b c0276f43 00000157 0000005b 0000006c 0026b6ff 000001f4
> 00000000
>        00000003 cd02a3c0 c012fb40 c0276fee cb8efe68 cb8efea8 cf941bc0
> c01706ab
>        c393a660 cf941c20 00000003 cb8efe68 cb8efea8 00000000 cd02a3c0
> c5ed5000
> Call Trace: [<c012fb40>] [<c01706ab>] [<c0140986>] [<c0138b6f>] [<c013930d>]
> [<c013995a>] [<c0136863>]
>        [<c0107044>] [<c0106f27>]
>  
> Code: 0f 0b 83 c4 0c 8b 54 24 3c 52 8b 44 24 3c 50 57 55 e8 25 fc
> Segmentation fault
>  
>  
> I am also getting some reiserfs errors. I don't know if this is related with
> the other two bugs. I coud not capture the text of this last error.
> 
> 
> Mickey Lalescu,  Application Architect
> Personus (Toronto)
> 36 Lombard Street., 3rd Floor, Toronto ON M5C 2X3
> TEL 416 941-9340 Ext. 134 FAX 416 941-9183
> EMAIL mickey@personus.com <mailto:mickey@personus.com>     WEB  <
> http://www.personus.com <http://www.personus.com/> > 
> 
> 
> 1 + 1 = 3 for huge values of 1 
> 
>  
> 

Andre Hedrick
Linux ATA Development
ASL Kernel Development
-----------------------------------------------------------------------------
ASL, Inc.                                     Toll free: 1-877-ASL-3535
1757 Houret Court                             Fax: 1-408-941-2071
Milpitas, CA 95035                            Web: www.aslab.com

