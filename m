Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317770AbSGKRex>; Thu, 11 Jul 2002 13:34:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317786AbSGKRew>; Thu, 11 Jul 2002 13:34:52 -0400
Received: from smtpzilla1.xs4all.nl ([194.109.127.137]:22032 "EHLO
	smtpzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id <S317770AbSGKRew>; Thu, 11 Jul 2002 13:34:52 -0400
Date: Thu, 11 Jul 2002 19:37:19 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Daniel Phillips <phillips@arcor.de>
cc: Rusty Russell <rusty@rustcorp.com.au>, Alexander Viro <viro@math.psu.edu>,
       "David S. Miller" <davem@redhat.com>, <adam@yggdrasil.com>,
       <R.E.Wolff@bitwizard.nl>, <linux-kernel@vger.kernel.org>
Subject: Re: Rusty's module talk at the Kernel Summit
In-Reply-To: <E17Sbat-0002TF-00@starship>
Message-ID: <Pine.LNX.4.44.0207111929500.8911-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 11 Jul 2002, Daniel Phillips wrote:

> Closing the rmmod race with this interface is easy.  We can for example just
> keep a state variable in the module struct (protected by a lock) to say the
> module is in the process of being deregistered.

Please check try_inc_mod_count(). It's already done.

bye, Roman


