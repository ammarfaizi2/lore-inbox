Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263488AbRFAMy0>; Fri, 1 Jun 2001 08:54:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263493AbRFAMyR>; Fri, 1 Jun 2001 08:54:17 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:4103 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S263473AbRFAMyE>; Fri, 1 Jun 2001 08:54:04 -0400
Subject: Re: [PATCH] support for Cobalt Networks (x86 only) systems (for realthis
To: jgarzik@mandrakesoft.com (Jeff Garzik)
Date: Fri, 1 Jun 2001 13:51:49 +0100 (BST)
Cc: bogdan.costescu@iwr.uni-heidelberg.de (Bogdan Costescu),
        zaitcev@redhat.com (Pete Zaitcev),
        linux-kernel@vger.kernel.org (Linux Kernel Mailing List)
In-Reply-To: <3B17889F.3118A564@mandrakesoft.com> from "Jeff Garzik" at Jun 01, 2001 08:20:47 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E155oP7-0000Sl-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> In both of these situations, calling the ioctls without priveleges is
> quite useful, so maybe rate-limiting for ioctls and proc files like this
> would be a good idea in general.

Many of them (like the MII and APM ones) the result can be cached 
