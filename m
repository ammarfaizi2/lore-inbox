Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267226AbSLRLHO>; Wed, 18 Dec 2002 06:07:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267227AbSLRLHO>; Wed, 18 Dec 2002 06:07:14 -0500
Received: from mailout01.sul.t-online.com ([194.25.134.80]:51864 "EHLO
	mailout01.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S267226AbSLRLHO> convert rfc822-to-8bit; Wed, 18 Dec 2002 06:07:14 -0500
Content-Type: text/plain; charset=US-ASCII
From: Oliver Neukum <oliver@neukum.name>
To: romieu@fr.zoreil.com, Colin Paul Adams <colin@colina.demon.co.uk>
Subject: Re: Alcatel speedtouch USB driver and SMP.
Date: Wed, 18 Dec 2002 12:13:33 +0100
User-Agent: KMail/1.4.3
Cc: linux-kernel@vger.kernel.org
References: <m3n0n7hi52.fsf@colina.demon.co.uk> <m3adj6gwus.fsf@colina.demon.co.uk> <20021217232010.A19613@electric-eye.fr.zoreil.com>
In-Reply-To: <20021217232010.A19613@electric-eye.fr.zoreil.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200212181213.33861.oliver@neukum.name>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 17. Dezember 2002 23:20 schrieb romieu@fr.zoreil.com:
> Colin Paul Adams <colin@colina.demon.co.uk> :
> [...]
>
> > So, is anyone using it on SMP?
>
> drivers/usb/misc/speedtouch.c::udsl_atm_ioctl() calls put_user() and
> atm ioctls are issued with spinlock held (see
> net/atm/common.c::atm_ioctl()).

Correct. As far as that is concerned the ATM layer is utter crap.

	Regards
		Oliver


