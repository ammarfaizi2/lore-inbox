Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275061AbRJANlk>; Mon, 1 Oct 2001 09:41:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275067AbRJANla>; Mon, 1 Oct 2001 09:41:30 -0400
Received: from smtp.alcove.fr ([212.155.209.139]:42770 "EHLO smtp.alcove.fr")
	by vger.kernel.org with ESMTP id <S275061AbRJANlQ>;
	Mon, 1 Oct 2001 09:41:16 -0400
Date: Mon, 1 Oct 2001 15:41:36 +0200
From: Stelian Pop <stelian.pop@fr.alcove.com>
To: jdthood@yahoo.co.uk
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PnPBIOS 2.4.9-ac1[56] Vaio fix
Message-ID: <20011001154136.K5531@come.alcove-fr>
Reply-To: Stelian Pop <stelian.pop@fr.alcove.com>
In-Reply-To: <20011001125401.9684B8BF@thanatos.toad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20011001125401.9684B8BF@thanatos.toad.net>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 01, 2001 at 08:54:01AM -0400, Thomas Hood wrote:

> Stelian: Okay, thanks for testing it.
> 
> Stelian and others:  So the fix works using is_sony_vaio_laptop
> to set the pnp_bios_dont_use_current_config flag. i

As I said, the DMI scan routines are still *after* the PnP 
driver initialization. I didn't really tested it, but I suspect
is_sony_vaio_laptop to be 0 when your routines are called.

Something else must have changed in your code to enable my Vaio to
boot...

Stelian.
-- 
Stelian Pop <stelian.pop@fr.alcove.com>
|---------------- Free Software Engineer -----------------|
| Alcôve - http://www.alcove.com - Tel: +33 1 49 22 68 00 |
|------------- Alcôve, liberating software ---------------|
