Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292422AbSBUPGW>; Thu, 21 Feb 2002 10:06:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292449AbSBUPGK>; Thu, 21 Feb 2002 10:06:10 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:262 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S292428AbSBUPFF>; Thu, 21 Feb 2002 10:05:05 -0500
Subject: Re: linux kernel config converter
To: jgarzik@mandrakesoft.com (Jeff Garzik)
Date: Thu, 21 Feb 2002 15:18:55 +0000 (GMT)
Cc: david.lang@digitalinsight.com (David Lang), andersen@codepoet.org,
        zippel@linux-m68k.org (Roman Zippel), linux-kernel@vger.kernel.org
In-Reply-To: <3C7505FC.52D5B08E@mandrakesoft.com> from "Jeff Garzik" at Feb 21, 2002 09:36:44 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16duzn-0007E0-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > 2. does it handle the 'I want this feature, turn on everything I need for
> > it'?
> 
> This is fundamentally impossible for anything beyond the most simple
> features. Although you can do a lot with config.in info, "everything I
> need" is something a human needs to define in many cases.

You can do that with CML1 or his code. The problem is that you need to
go back through checking with the user because

-	Some requirements are going to suprise and may stop other
	settings

	(Simple example  "I want GMX2000 support" -> requires DRM 4.0
	DRM 4.0 requires they turn off some DRM 4.1 stuff they selected

-	Some have alternate solutions

But you can deduce what to ask the user
