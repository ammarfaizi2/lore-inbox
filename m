Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280002AbRKRSg0>; Sun, 18 Nov 2001 13:36:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280012AbRKRSgP>; Sun, 18 Nov 2001 13:36:15 -0500
Received: from femail39.sdc1.sfba.home.com ([24.254.60.33]:57298 "EHLO
	femail39.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S280002AbRKRSgG>; Sun, 18 Nov 2001 13:36:06 -0500
Subject: Re: Driver callback routine when panic() is called
From: Georg Nikodym <georgn@somanetworks.com>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <1006008556.1923.20.camel@keller>
In-Reply-To: <17427.1005997080@ocs3.intra.ocs.com.au> 
	<1006008556.1923.20.camel@keller>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.1+cvs.2001.11.14.08.58 (Preview Release)
Date: 18 Nov 2001 13:36:00 -0500
Message-Id: <1006108560.1923.22.camel@keller>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2001-11-17 at 09:49, Georg Nikodym wrote:

> Pat O'Rourke also posted a patch[1] that exposes this nicely
> (panic_notifier_list is currently static in panic.c).

Musta been smoking the good stuff.  panic_notifier_list is not static at
all and is extern'ed in kernel.h.  Pat's patch just adds a functional
interface...

Time to get the old eyes checked.

