Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266606AbRGHBT3>; Sat, 7 Jul 2001 21:19:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266611AbRGHBTJ>; Sat, 7 Jul 2001 21:19:09 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:17413 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S266606AbRGHBS7>; Sat, 7 Jul 2001 21:18:59 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: =?iso-8859-1?q?Jos=E9=20Luis=20Domingo=20L=F3pez?= 
	<jldomingo@crosswinds.net>,
        linux-kernel@vger.kernel.org
Subject: Re: OOM: A Success Report
Date: Sun, 8 Jul 2001 03:20:37 +0200
X-Mailer: KMail [version 1.2]
In-Reply-To: <20010708004051.A4765@dardhal.mired.net>
In-Reply-To: <20010708004051.A4765@dardhal.mired.net>
MIME-Version: 1.0
Message-Id: <01070803203709.22952@starship>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Moreover, when swap is of, the hard disk
> goes crazy as if it where using swap, when in fact it isn't). Is this
> expected behaviour ?

Yes, it's recovering memory by dropping program text pages (memory 
mapped from elf files) so those have to be reloaded when the program 
executes them again.

--
Daniel
