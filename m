Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291611AbSBTCOm>; Tue, 19 Feb 2002 21:14:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291608AbSBTCOd>; Tue, 19 Feb 2002 21:14:33 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:44549 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S291611AbSBTCOT>; Tue, 19 Feb 2002 21:14:19 -0500
Subject: Re: sis_malloc / sis_free
To: sartre@linuxbr.com (Jean Paul Sartre)
Date: Wed, 20 Feb 2002 02:28:12 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        linux-kernel@vger.kernel.org (Linux Kernel Mailing List)
In-Reply-To: <Pine.LNX.4.40.0202192307120.13176-100000@sartre.linuxbr.com> from "Jean Paul Sartre" at Feb 19, 2002 11:11:28 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16dMUO-0002Ix-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 	Okay, will try 2.4.18rc2-ac1. Ahn, If CONFIG_FB_SIS is set,
> CONFIG_DRM_SIS still appears in the menuconfig option. Is it okay, as DRM
> requires FB support?

You need both DRM_SIS and FB_SIS set. At the moment thats not properly
enforced in the CML1
