Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290461AbSAYC6C>; Thu, 24 Jan 2002 21:58:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290519AbSAYC5w>; Thu, 24 Jan 2002 21:57:52 -0500
Received: from sombre.2ka.mipt.ru ([194.85.82.77]:1920 "EHLO
	sombre.2ka.mipt.ru") by vger.kernel.org with ESMTP
	id <S290461AbSAYC5b>; Thu, 24 Jan 2002 21:57:31 -0500
Date: Fri, 25 Jan 2002 05:57:15 +0300
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: davej@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.3-pre3 -- aironet4500_core.c:2839:  In function `awc_init': incompatible types in return
Message-Id: <20020125055715.12f372e9.johnpol@2ka.mipt.ru>
In-Reply-To: <20020123210246.5e5cfb3f.johnpol@2ka.mipt.ru>
In-Reply-To: <1011771248.24309.60.camel@stomata.megapathdsl.net>
	<20020123104550.16b160b0.johnpol@2ka.mipt.ru>
	<20020123140044.E31032@suse.de>
	<20020123210246.5e5cfb3f.johnpol@2ka.mipt.ru>
Reply-To: johnpol@2ka.mipt.ru
Organization: MIPT
X-Mailer: Sylpheed version 0.7.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Jan 2002 21:02:46 +0300
Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:

> >  > -       return NODEV;
> >  > +       return -1;
> 
> >  This should probably be return -ENODEV
> 
> It sould be negative integer.
> kdev_val(NODEV) == 0, so it will indicate successive finish, that is not
> right.

Ooops, sorry, this <censored> was written probably on drugs...
You absolutely right, and i didn't see 'E' letter in your mail.
Take my appologize.

> > -- 
> > | Dave Jones.        http://www.codemonkey.org.uk
> > | SuSE Labs

	Evgeniy Polyakov ( s0mbre ).
