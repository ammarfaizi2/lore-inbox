Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272978AbSISUik>; Thu, 19 Sep 2002 16:38:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272979AbSISUik>; Thu, 19 Sep 2002 16:38:40 -0400
Received: from smtpzilla1.xs4all.nl ([194.109.127.137]:61957 "EHLO
	smtpzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id <S272978AbSISUij>; Thu, 19 Sep 2002 16:38:39 -0400
Date: Thu, 19 Sep 2002 22:42:55 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Greg KH <greg@kroah.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Rusty Russell <rusty@rustcorp.com.au>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] In-kernel module loader 1/7
In-Reply-To: <20020919201140.GB17131@kroah.com>
Message-ID: <Pine.LNX.4.44.0209192233040.8911-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 19 Sep 2002, Greg KH wrote:

> > So the LSM module always says no. Don't make other modules suffer
>
> Ok, I don't have a problem with that, I was just trying to point out
> that not all modules can know when they are able to be unloaded, as
> Roman stated.

That's not really what I meant. Only the module can know whether it's safe
and somehow has to tell that module.c. The question is now how that should
be done.

bye, Roman

