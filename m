Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263006AbVCEKrH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263006AbVCEKrH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 05:47:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263017AbVCEKrG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 05:47:06 -0500
Received: from mx2.mail.ru ([194.67.23.122]:65362 "EHLO mx2.mail.ru")
	by vger.kernel.org with ESMTP id S263006AbVCEKqz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 05:46:55 -0500
From: Alexey Dobriyan <adobriyan@mail.ru>
To: Coywolf Qi Hunt <coywolf@gmail.com>
Subject: Re: [patch] remove the `.' in EXTRAVERSION usage
Date: Sat, 5 Mar 2005 13:47:08 +0200
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org, greg@kroah.com, akpm@osdl.org
References: <2cd57c90050305022211b94e86@mail.gmail.com>
In-Reply-To: <2cd57c90050305022211b94e86@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200503051347.08860.adobriyan@mail.ru>
X-Spam: Not detected
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 05 March 2005 12:22, Coywolf Qi Hunt wrote:

> Since 2.6.9, there came along the LOCALVERSION for people to add local
> version in make menuconfig which was EXTRAVERSION originally for imho.
> Now EXTRAVERSION goes just as a kernel version number, it's reasonable
> to remove the `.' in its usage.

> -KERNELRELEASE=$(VERSION).$(PATCHLEVEL).$(SUBLEVEL)$(EXTRAVERSION)$(LOCALVERSION)
> +KERNELRELEASE=$(VERSION).$(PATCHLEVEL).$(SUBLEVEL).$(EXTRAVERSION)$(LOCALVERSION)

You want 2.6.11.-mm2 or 2.6.11.mm2 ? :-)

	Alexey
