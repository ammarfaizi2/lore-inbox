Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317036AbSGHSQU>; Mon, 8 Jul 2002 14:16:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317034AbSGHSQT>; Mon, 8 Jul 2002 14:16:19 -0400
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:28803
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S317030AbSGHSQR>; Mon, 8 Jul 2002 14:16:17 -0400
Date: Mon, 8 Jul 2002 11:18:38 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Riley Williams <rhw@infradead.org>
Cc: Justin Hibbits <jrh29@po.cwru.edu>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Michael Elizabeth Chastain <mec@shout.net>
Subject: Re: Patch for Menuconfig script
Message-ID: <20020708181838.GL695@opus.bloom.county>
References: <20020708151412.GB695@opus.bloom.county> <Pine.LNX.4.21.0207081841380.9595-100000@Consulate.UFP.CX>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0207081841380.9595-100000@Consulate.UFP.CX>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 08, 2002 at 06:44:55PM +0100, Riley Williams wrote:
> Hi Tom.
> 
> >>> This is just a patch to the Menuconfig script (can be easily adapted
> >>> to the other ones) that allows you to configure the kernel without
> >>> the requirement of bash (I tested it with ksh, in POSIX-only mode).  
> >>> Feel free to flame me :P
> 
> >> Does it also work in the case where the current shell is csh or tcsh
> >> (for example)?
> 
> > Er.. why wouldn't it?
> > $ head -1 scripts/Menuconfig 
> > #! /bin/sh
> 
> > So this removes the /bin/sh is not bash test, yes?
> 
>  Q> # ls -l /bin/sh | tr -s '\t' ' '
>  Q> lrwxrwxrwx 1 root root 4 May 7 1999 /bin/sh -> tcsh
>  Q> #
> 
> You tell me - the above is from one of the systems I regularly use,
> which does not even have bash installed...

So does tcsh work as a POSIX-sh when invoked as /bin/sh ?

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
