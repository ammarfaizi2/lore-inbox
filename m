Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317928AbSGWM5n>; Tue, 23 Jul 2002 08:57:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317935AbSGWM5n>; Tue, 23 Jul 2002 08:57:43 -0400
Received: from ns.suse.de ([213.95.15.193]:29450 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S317928AbSGWM5m>;
	Tue, 23 Jul 2002 08:57:42 -0400
Date: Tue, 23 Jul 2002 15:00:45 +0200
From: Dave Jones <davej@suse.de>
To: Thunder from the hill <thunder@ngforever.de>
Cc: Ingo Molnar <mingo@elte.hu>, Marcel Holtmann <marcel@holtmann.org>,
       Linus Torvalds <torvalds@transmeta.com>,
       Maksim Krasnyanskiy <maxk@qualcomm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Subject: Re: [PATCH] Bluetooth Subsystem PC Card drivers for 2.5.27
Message-ID: <20020723150045.D14323@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Thunder from the hill <thunder@ngforever.de>,
	Ingo Molnar <mingo@elte.hu>, Marcel Holtmann <marcel@holtmann.org>,
	Linus Torvalds <torvalds@transmeta.com>,
	Maksim Krasnyanskiy <maxk@qualcomm.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
References: <Pine.LNX.4.44.0207231424380.9226-100000@localhost.localdomain> <Pine.LNX.4.44.0207230628500.3200-100000@hawkeye.luckynet.adm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.44.0207230628500.3200-100000@hawkeye.luckynet.adm>; from thunder@ngforever.de on Tue, Jul 23, 2002 at 06:29:38AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 23, 2002 at 06:29:38AM -0600, Thunder from the hill wrote:

 > Because once it became standard, we want to remove it somewhen. It's 
 > sometimes a bit ridiculous when you read it...

Completely removing it means driver maintainers need to keep
separate 2.4/2.6 versions of their drivers. The extra EXPORT_NO_SYMBOLS
is harmless, and allows single source, multi kernel version drivers.

        Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
