Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274848AbRJAKRl>; Mon, 1 Oct 2001 06:17:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274850AbRJAKRc>; Mon, 1 Oct 2001 06:17:32 -0400
Received: from smtp.alcove.fr ([212.155.209.139]:18447 "EHLO smtp.alcove.fr")
	by vger.kernel.org with ESMTP id <S274848AbRJAKRR>;
	Mon, 1 Oct 2001 06:17:17 -0400
Date: Mon, 1 Oct 2001 12:04:33 +0200
From: Stelian Pop <stelian.pop@fr.alcove.com>
To: Thomas Hood <jdthood@home.dhs.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PnPBIOS 2.4.9-ac1[56] Vaio fix
Message-ID: <20011001120432.A5531@come.alcove-fr>
Reply-To: Stelian Pop <stelian.pop@fr.alcove.com>
In-Reply-To: <20010930174627.52817587@thanatos.toad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20010930174627.52817587@thanatos.toad.net>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 30, 2001 at 01:46:26PM -0400, Thomas Hood wrote:

> Here's the patch to the PnP BIOS driver for Vaio laptops again,
> this time against 2.4.9-ac18.  It's unchanged, but as per the
> "SubmittingPatches" file, I append rather than attach it.   
> // Thomas

Ok, here I am again, sorry for not being able to react on 
your patches this weekend...

I tested your latest patches with a 2.4.9-ac18 kernels, and,
surprise, the kernel now boots correctly, _without_ any
pnpbios* boot option.

Since the DMI / PNP order was not modified as of ac18, I
suppose the patches change something else which makes it
work...

Stelian.
-- 
Stelian Pop <stelian.pop@fr.alcove.com>
|---------------- Free Software Engineer -----------------|
| Alcôve - http://www.alcove.com - Tel: +33 1 49 22 68 00 |
|------------- Alcôve, liberating software ---------------|
