Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132804AbRDNBJh>; Fri, 13 Apr 2001 21:09:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132805AbRDNBJ1>; Fri, 13 Apr 2001 21:09:27 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:29199 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S132804AbRDNBJV>; Fri, 13 Apr 2001 21:09:21 -0400
Subject: Re: errors(?) in configuration rule files (config.in/Config.in)
To: Malte.Starostik@t-online.de (Malte Starostik)
Date: Sat, 14 Apr 2001 02:10:58 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200104140028.f3E0SMO07528@servant.home.lan> from "Malte Starostik" at Apr 14, 2001 02:28:21 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14oEaa-0003vy-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> those contain two default values? For now I made the parser ignore the 
> $CONFIG_SB_* defaults and use the immediate numbers. How should those be 
> treated / could they be fixed?

Use the first value which is non null string.

> In 2.4.2 at least:
> drivers/char/Config.in, line 179:
> tristate '/dev/agpgart (AGP Support)' CONFIG_AGP $CONFIG_DRM_AGP
> According to Documentation/kbuild/config-language.txt, tristate accepts no 
> default value.

Thats a bug. Several of these are fixed already tho

> 

