Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316860AbSGHPMU>; Mon, 8 Jul 2002 11:12:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316895AbSGHPMT>; Mon, 8 Jul 2002 11:12:19 -0400
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:12418
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S316860AbSGHPMP>; Mon, 8 Jul 2002 11:12:15 -0400
Date: Mon, 8 Jul 2002 08:14:12 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Riley Williams <rhw@InfraDead.Org>
Cc: Justin Hibbits <jrh29@po.cwru.edu>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Michael Elizabeth Chastain <mec@shout.net>
Subject: Re: Patch for Menuconfig script
Message-ID: <20020708151412.GB695@opus.bloom.county>
References: <3D2793CB.90002@po.cwru.edu> <Pine.LNX.4.21.0207072319440.9595-100000@Consulate.UFP.CX>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0207072319440.9595-100000@Consulate.UFP.CX>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 07, 2002 at 11:22:10PM +0100, Riley Williams wrote:
> Hi Justin.
> 
> > This is just a patch to the Menuconfig script (can be easily adapted
> > to the other ones) that allows you to configure the kernel without
> > the requirement of bash (I tested it with ksh, in POSIX-only mode).  
> > Feel free to flame me :P
> 
> Does it also work in the case where the current shell is csh or tcsh
> (for example)?

Er.. why wouldn't it?
$ head -1 scripts/Menuconfig 
#! /bin/sh

So this removes the /bin/sh is not bash test, yes?

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
