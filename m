Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290752AbSBTBhi>; Tue, 19 Feb 2002 20:37:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290746AbSBTBh3>; Tue, 19 Feb 2002 20:37:29 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:21765 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S290752AbSBTBhX>; Tue, 19 Feb 2002 20:37:23 -0500
Subject: Re: sis_malloc / sis_free
To: sartre@linuxbr.com (Jean Paul Sartre)
Date: Wed, 20 Feb 2002 01:51:15 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org (Linux Kernel Mailing List)
In-Reply-To: <Pine.LNX.4.40.0202192220550.13176-100000@sartre.linuxbr.com> from "Jean Paul Sartre" at Feb 19, 2002 10:26:37 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16dLud-0002Bk-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 'shares' code with the fb code. What if I have SIS framebuffer disabled
> and SIS DRM code enabled? In 2.4.18-rc2, the SIS DRM code does not compile
> from the lack of sis_malloc and sis_free function.

SIS DRM requires the SIS frame buffer.
