Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263219AbUDZSxK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263219AbUDZSxK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Apr 2004 14:53:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263215AbUDZSxJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Apr 2004 14:53:09 -0400
Received: from RJ141219067.user.veloxzone.com.br ([200.141.219.67]:29126 "EHLO
	pervalidus.dyndns.org") by vger.kernel.org with ESMTP
	id S263219AbUDZSwg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Apr 2004 14:52:36 -0400
Date: Mon, 26 Apr 2004 15:52:05 -0300 (BRT)
From: =?ISO-8859-1?Q?Fr=E9d=E9ric_L=2E_W=2E_Meunier?= <1@pervalidus.net>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-rc2-mm2
In-Reply-To: <20040426013944.49a105a8.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0404261547040.1796@pervalidus.dyndns.org>
References: <20040426013944.49a105a8.akpm@osdl.org>
X-Archive: encrypt
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Apr 2004, Andrew Morton wrote:

> - Several more framebuffer driver update, some quite
> substantial.

Still broken for me, as reported at
http://marc.theaimsgroup.com/?l=linux-kernel&m=108269975708471&w=2

I tried manually, and it happens after con2fb /dev/fb0
/dev/tty1.

Maybe framebuffer as modules is broken, who knows...

CONFIG_FB=y
CONFIG_VIDEO_SELECT=y
CONFIG_FB_MATROX=m
CONFIG_FB_MATROX_G450=y
CONFIG_FB_MATROX_G100=y
CONFIG_VGA_CONSOLE=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_FRAMEBUFFER_CONSOLE=y
CONFIG_PCI_CONSOLE=y
CONFIG_FONTS=y
CONFIG_FONT_8x16=y
CONFIG_LOGO=y
CONFIG_LOGO_LINUX_CLUT224=y

-- 
http://www.pervalidus.net/contact.html
