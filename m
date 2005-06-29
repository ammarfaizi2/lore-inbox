Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262509AbVF2Krl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262509AbVF2Krl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 06:47:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262513AbVF2Krk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 06:47:40 -0400
Received: from smtp.osdl.org ([65.172.181.4]:31212 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262509AbVF2Krf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 06:47:35 -0400
Date: Wed, 29 Jun 2005 03:46:46 -0700
From: Andrew Morton <akpm@osdl.org>
To: Bodo Eggert <7eggert@gmx.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] menu -> menuconfig changes
Message-Id: <20050629034646.18627190.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0506291131320.3554@be1.lrz>
References: <Pine.LNX.4.58.0506291131320.3554@be1.lrz>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bodo Eggert <7eggert@gmx.de> wrote:
>
> There are many submenus in the config system where the fist option 
>  controls the availability of the remaining options. This is very 
>  inconvenient in menuconfig, since you'll have to enter each menu
>  to see whether or not the corresponding subsystem is enabled.
> 
>  I suggest moving the first option out of the subsystem by changing
>  'menu' to 'menuconfig', as demonstrated by the patch below.

I'd agree with that.

>  --- ../linux-2.6.12/drivers/cdrom/Kconfig	2005-06-19 14:16:31.000000000 +0200
>  +++ ./drivers/cdrom/Kconfig	2005-06-29 11:27:02.000000000 +0200

eww.

   --- a/drivers/cdrom/Kconfig
   +++ a/drivers/cdrom/Kconfig

please.
