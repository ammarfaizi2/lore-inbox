Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318066AbSGLX3E>; Fri, 12 Jul 2002 19:29:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318067AbSGLX3D>; Fri, 12 Jul 2002 19:29:03 -0400
Received: from pc132.utati.net ([216.143.22.132]:19077 "HELO
	merlin.webofficenow.com") by vger.kernel.org with SMTP
	id <S318066AbSGLX3C>; Fri, 12 Jul 2002 19:29:02 -0400
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
To: Thunder from the hill <thunder@ngforever.de>
Subject: Re: No rule to make autoconf.h in 2.4.19-rc1?
Date: Fri, 12 Jul 2002 13:33:31 -0400
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0207121526421.3421-100000@hawkeye.luckynet.adm>
In-Reply-To: <Pine.LNX.4.44.0207121526421.3421-100000@hawkeye.luckynet.adm>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020712231123.2C7AE8B5@merlin.webofficenow.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 12 July 2002 05:27 pm, Thunder from the hill wrote:
> Hi,
>
> On Fri, 12 Jul 2002, Rob Landley wrote:
> > What does the kernel use autoconf for?  (When did this get added?  I
> > wrote a kernel output parser and didn't see autoconf, and I'd expect it
> > to run in ake dep anyway...)
>
> This is your kernel configuration. Please run make
> configure/oldconfig/menuconfig before running make dep.

Actually, I was.  But it was in a script run on a detached terminal with 
watched output, and I wasn't going yes "" | make oldconfig.  (Error checking. 
 Good thing.  It DID work under 2.4.18, because oldconfig didn't prompt for 
anything. :)

> 							Regards,
> 							Thunder

Rob
