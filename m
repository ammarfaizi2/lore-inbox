Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318021AbSGLV1V>; Fri, 12 Jul 2002 17:27:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318023AbSGLV1U>; Fri, 12 Jul 2002 17:27:20 -0400
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:19729 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id <S318021AbSGLV1U>; Fri, 12 Jul 2002 17:27:20 -0400
Date: Fri, 12 Jul 2002 23:30:06 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Dave Jones <davej@suse.de>
cc: Thunder from the hill <thunder@ngforever.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [CHECKER] 56 potential lock/unlock bugs in 2.5.8
In-Reply-To: <20020712224820.D18503@suse.de>
Message-ID: <Pine.LNX.4.44.0207122253250.28515-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 12 Jul 2002, Dave Jones wrote:

>  > Which kernel version? It looks like a bug which already has been fixed
>  > quite some time ago.
>
> 2.5.25-dj1. I expect the same problem to exist in mainline if its
> AFFS specific, as I currently have no patches in that area.

I'm just testing it with 2.4.18 under uml and it runs happily. The 2.4 and
2.5 are basically identical, so it's really strange. What I can see from
the disassembly it must be an old affs version.

bye, Roman

