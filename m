Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265140AbTBTP21>; Thu, 20 Feb 2003 10:28:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265513AbTBTP20>; Thu, 20 Feb 2003 10:28:26 -0500
Received: from smtpzilla1.xs4all.nl ([194.109.127.137]:11023 "EHLO
	smtpzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id <S265140AbTBTP20>; Thu, 20 Feb 2003 10:28:26 -0500
Date: Thu, 20 Feb 2003 16:38:22 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: "Adam J. Richter" <adam@yggdrasil.com>
cc: linux-kernel@vger.kernel.org, Rusty Russell <rusty@rustcorp.com.au>,
       <wa@almesberger.net>
Subject: Re: [RFC] Is an alternative module interface needed/possible?
In-Reply-To: <200302201351.FAA08649@baldur.yggdrasil.com>
Message-ID: <Pine.LNX.4.44.0302201628300.1336-100000@serv>
References: <200302201351.FAA08649@baldur.yggdrasil.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 20 Feb 2003, Adam J. Richter wrote:

> 	Anyhow, my point is that removing a piece of hardware
> does not require that the corresponding module be unloaded
> immediately.

That's true, but when a piece of hardware is removed, you usually also 
want to get rid of some data structures, but if the relevant functions are 
not prepared to be called outside of module_exit, you have a huge problem.

bye, Roman

