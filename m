Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277068AbRJDBkP>; Wed, 3 Oct 2001 21:40:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277070AbRJDBkF>; Wed, 3 Oct 2001 21:40:05 -0400
Received: from dclient217-162-20-87.hispeed.ch ([217.162.20.87]:44403 "EHLO
	pismo") by vger.kernel.org with ESMTP id <S277068AbRJDBjs> convert rfc822-to-8bit;
	Wed, 3 Oct 2001 21:39:48 -0400
Subject: Re: Panic on PowerPC
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <daenzer@debian.org>
To: =?us-ascii?Q?Rog=E9rio?= Brito <rbrito@ime.usp.br>
Cc: linux-kernel@vger.kernel.org, debian-powerpc@lists.debian.org
In-Reply-To: <20011003222219.A487@iname.com>
In-Reply-To: <20011003222219.A487@iname.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-Mailer: Evolution/0.14 (Preview Release)
Date: 04 Oct 2001 03:40:06 +0200
Message-Id: <1002159607.2363.16.camel@pismo>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2001-10-04 at 03:22, =?us-ascii?Q?Rog=E9rio?= Brito wrote:

> >>NIP; c0005d58 <__sti+8/50>   <=====
> Trace; c01758c8 <rtc_init+b8/16c>
> Trace; c016576c <do_initcalls+30/50>
> Trace; c01657b8 <do_basic_setup+2c/3c>
> Trace; c00038a4 <init+14/1b0>
> Trace; c00062a4 <kernel_thread+34/40>

Disable CONFIG_RTC, only enable CONFIG_PPC_RTC in the kernel config.


-- 
Earthling Michel Dänzer (MrCooper)/ Debian GNU/Linux (powerpc) developer
XFree86 and DRI project member   /  CS student, Free Software enthusiast
