Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317373AbSFHA5z>; Fri, 7 Jun 2002 20:57:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317374AbSFHA5y>; Fri, 7 Jun 2002 20:57:54 -0400
Received: from bgp01360964bgs.sandia01.nm.comcast.net ([68.35.68.128]:12672
	"EHLO orion.dwf.com") by vger.kernel.org with ESMTP
	id <S317373AbSFHA5x>; Fri, 7 Jun 2002 20:57:53 -0400
Message-Id: <200206080057.g580vmJh001282@orion.dwf.com>
X-Mailer: exmh version 2.5 01/15/2001 with nmh-1.0.4
To: linux-kernel@vger.kernel.org
Subject: I2C stuff has undefined externals in 2.4.18
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 07 Jun 2002 18:57:48 -0600
From: reg@dwf.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just tried building the I2C stuff in 2.4.18, 
I selected 
	I2C support
and     I2C /proc interface.

as modules.  
The compile went ok, but the depmod after the install claimed that
	i2c-hydra
	i2c-i810
	i2c-via
	i2c-voodoo3
all had undefined externals.
Does someone familiar with the code want to take a look?


-- 
                                        Reg.Clemens
                                        reg@dwf.com


