Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316895AbSGHPTh>; Mon, 8 Jul 2002 11:19:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316964AbSGHPTg>; Mon, 8 Jul 2002 11:19:36 -0400
Received: from wedge.SCL.CWRU.Edu ([129.22.134.36]:44000 "HELO
	wedge.scl.cwru.edu") by vger.kernel.org with SMTP
	id <S316957AbSGHPTe>; Mon, 8 Jul 2002 11:19:34 -0400
Message-ID: <20020708152215.11552.qmail@wedge.scl.cwru.edu>
To: Tom Rini <trini@kernel.crashing.org>
From: "Justin R Hibbits" <jrh29@po.cwru.edu>
Date: Mon,  8 Jul 2002 11:22:15 -0400
Subject: Re: Patch for Menuconfig script
Cc: linux-kernel@vger.kernel.org
Reply-To: jrh29@po.cwru.edu
In-Reply-To-Local-Message: <0000000000000000000000000000000000000000000000
    0000002PWU>
In-Reply-To: <20020708151412.GB695@opus.bloom.county>
X-Mailer: SIS WebMail Compose v1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This removes the test, and also fixes the function declarations ( changes them
from 'function blah ()' to just 'blah ()' ) to make it more of a POSIX sh
script.  As I put in my other reply (started another thread...problems
explained there :P ), I've only tested it on my system with 2.4.18 and ksh (but
should work out of the box on any 2.4.xx, and with little modification on
2.5.xx).

Justin Hibbits


On 07/08/02 11:14:12, Tom Rini <trini@kernel.crashing.org> wrote:
> On Sun, Jul 07, 2002 at 11:22:10PM +0100, Riley Williams wrote:
> > Hi Justin.
> > 
> > > This is just a patch to the Menuconfig script (can be easily adapted
> > > to the other ones) that allows you to configure the kernel without
> > > the requirement of bash (I tested it with ksh, in POSIX-only mode).  
> > > Feel free to flame me :P
> > 
> > Does it also work in the case where the current shell is csh or tcsh
> > (for example)?
> 
> Er.. why wouldn't it?
> $ head -1 scripts/Menuconfig 
> #! /bin/sh
> 
> So this removes the /bin/sh is not bash test, yes?
> 
> -- 
> Tom Rini (TR1265)
> http://gate.crashing.org/~trini/
