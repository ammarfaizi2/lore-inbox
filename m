Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310661AbSCMP2c>; Wed, 13 Mar 2002 10:28:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310660AbSCMP2W>; Wed, 13 Mar 2002 10:28:22 -0500
Received: from smtp-sec1.zid.nextra.de ([212.255.127.204]:16902 "EHLO
	smtp-sec1.zid.nextra.de") by vger.kernel.org with ESMTP
	id <S310658AbSCMP2I>; Wed, 13 Mar 2002 10:28:08 -0500
Date: Wed, 13 Mar 2002 16:27:49 +0100 (CET)
From: Guennadi Liakhovetski <gl@dsa-ac.de>
To: ARM Linux kernel <linux-arm-kernel@lists.arm.linux.org.uk>,
        <linux-kernel@vger.kernel.org>
Subject: CONFIG_SOUND_GAMEPORT in 2.5
Message-ID: <Pine.LNX.4.33.0203131625510.15512-100000@pcgl.dsa-ac.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everybody. The following extract from
drivers/input/gameport/Config.in doesn't seem quite right to me, in
general and for ARM specifically:
if [ "$CONFIG_GAMEPORT" = "m" ]; then
	define_tristate CONFIG_SOUND_GAMEPORT m
fi
if [ "$CONFIG_GAMEPORT" != "m" ]; then
	define_tristate CONFIG_SOUND_GAMEPORT y
fi

Could the maintainer please change this?

Thanks
Guennadi
---------------------------------
Guennadi Liakhovetski, Ph.D.
DSA Daten- und Systemtechnik GmbH
Pascalstr. 28
D-52076 Aachen
Germany

