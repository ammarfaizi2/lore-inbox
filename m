Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318012AbSGLVxW>; Fri, 12 Jul 2002 17:53:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318013AbSGLVxW>; Fri, 12 Jul 2002 17:53:22 -0400
Received: from smtpzilla1.xs4all.nl ([194.109.127.137]:9488 "EHLO
	smtpzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id <S318012AbSGLVxU>; Fri, 12 Jul 2002 17:53:20 -0400
Date: Fri, 12 Jul 2002 23:56:07 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Dave Jones <davej@suse.de>
cc: Thunder from the hill <thunder@ngforever.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [CHECKER] 56 potential lock/unlock bugs in 2.5.8
In-Reply-To: <20020712233849.G18503@suse.de>
Message-ID: <Pine.LNX.4.44.0207122348090.28515-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 12 Jul 2002, Dave Jones wrote:

> if 2.4/2.5 AFFS is in sync as you say (which iirc it is), then
> I fail to see how you think the 2.5.25 disassembly is an old version.

The last disassembled instruction is the PageUptodate() test, which was
moved in later versions and can't be that early in the function for a
recent version, but the disassembly is exactly what I would expect from
an old affs version.

bye, Roman

