Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272872AbTHPMYH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Aug 2003 08:24:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272874AbTHPMYH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Aug 2003 08:24:07 -0400
Received: from co239024-a.almel1.ov.home.nl ([217.120.226.100]:39833 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S272872AbTHPMYF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Aug 2003 08:24:05 -0400
Date: Sat, 16 Aug 2003 14:20:40 +0200 (CEST)
From: Aschwin Marsman <aschwin@marsman.org>
X-X-Sender: marsman@localhost.localdomain
To: linux-kernel@vger.kernel.org
Subject: 2.4.22-rc2 bk current: unresolved symbols in scx200_i2c.o
Message-ID: <Pine.LNX.4.44.0308161417020.1815-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

When compiling 2.4.22-rc2 bk current (20030816 9:00 UTC), I get the following:

depmod: *** Unresolved symbols in /lib/modules/2.4.22-rc2/kernel/drivers/i2c/scx200_i2c.o
depmod:         scx200_gpio_base_R254e5667
depmod:         scx200_gpio_configure_R80c65a79
depmod:         scx200_gpio_shadow_R9272bc53

Relevant part of .config:

CONFIG_I2C=m
CONFIG_I2C_ALGOBIT=m
CONFIG_I2C_PHILIPSPAR=m
CONFIG_I2C_ELV=m
CONFIG_I2C_VELLEMAN=m
CONFIG_SCx200_I2C=m
CONFIG_SCx200_I2C_SCL=12
CONFIG_SCx200_I2C_SDA=13
CONFIG_SCx200_ACB=m
CONFIG_I2C_ALGOPCF=m
CONFIG_I2C_ELEKTOR=m
CONFIG_I2C_CHARDEV=m
CONFIG_I2C_PROC=m

Have fun & a nice weekend,
 
Aschwin Marsman

