Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264811AbTB0MYh>; Thu, 27 Feb 2003 07:24:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264813AbTB0MYh>; Thu, 27 Feb 2003 07:24:37 -0500
Received: from smtpzilla1.xs4all.nl ([194.109.127.137]:58119 "EHLO
	smtpzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id <S264811AbTB0MYg>; Thu, 27 Feb 2003 07:24:36 -0500
Date: Thu, 27 Feb 2003 13:34:18 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Werner Almesberger <wa@almesberger.net>
cc: Rusty Russell <rusty@rustcorp.com.au>, <kuznet@ms2.inr.ac.ru>,
       <kronos@kronoz.cjb.net>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Is an alternative module interface needed/possible?
In-Reply-To: <20030226202647.H2092@almesberger.net>
Message-ID: <Pine.LNX.4.44.0302271321190.1336-100000@serv>
References: <20030217221837.Q2092@almesberger.net> <20030218050349.44B092C04E@lists.samba.org>
 <20030218042042.R2092@almesberger.net> <Pine.LNX.4.44.0302181252570.1336-100000@serv>
 <20030218111215.T2092@almesberger.net> <20030218142257.A10210@almesberger.net>
 <Pine.LNX.4.44.0302191454520.1336-100000@serv> <20030219231710.Y2092@almesberger.net>
 <Pine.LNX.4.44.0302212202020.1336-100000@serv> <20030226202647.H2092@almesberger.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 26 Feb 2003, Werner Almesberger wrote:

> Roman Zippel wrote:
> > Anyway, this alone would be not reason enough to change the module 
> > interface, but another module interface would give us more flexibility and 
> > reduce the locking complexity.
> 
> Wait, wait ! :-) There's one step you've left out: what we actually
> expect the module interface to do. We have:

There are several module interfaces:
- module user interface
- module load interface
- module driver interface

These are quite independent and so far we were talking about the last one, 
so I'm a bit confused about your request to talk about the first.
<rant>
BTW Why Rusty had to completely break the first two interfaces to 
"improve" the last one, is probably another mystery, I'll never 
understand.
</rant>

bye, Roman

