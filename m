Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271571AbRHQMDq>; Fri, 17 Aug 2001 08:03:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271587AbRHQMDf>; Fri, 17 Aug 2001 08:03:35 -0400
Received: from cobae1.consultronics.on.ca ([205.210.130.26]:51863 "EHLO
	cobae1.consultronics.on.ca") by vger.kernel.org with ESMTP
	id <S271571AbRHQMDR>; Fri, 17 Aug 2001 08:03:17 -0400
Date: Fri, 17 Aug 2001 08:03:30 -0400
From: Greg Louis <glouis@dynamicro.on.ca>
To: LKML <linux-kernel@vger.kernel.org>
Subject: 2.4.8-ac6 ad1848 module failed at init
Message-ID: <20010817080330.A613@athame.dynamicro.on.ca>
Reply-To: Greg Louis <glouis@dynamicro.on.ca>
Mail-Followup-To: LKML <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Organization: Dynamicro Consulting Limited
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In kernel 2.4.8-ac6, with
# CONFIG_PNP is not set
# CONFIG_ISAPNP is not set
# CONFIG_PNPBIOS is not set
CONFIG_SOUND=y
CONFIG_SOUND_OSS=m
CONFIG_SOUND_TRACEINIT=y
CONFIG_SOUND_DMAP=y
CONFIG_SOUND_TRIX=m
CONFIG_SOUND_SB=m
CONFIG_SOUND_YM3812=m
module ad1848 built but failed at init with "No device found."

I reverted, by copying ad1848.c from the -ac4 tree, and the resulting
module loaded successfully, and seems to be functioning correctly.

-- 
| G r e g  L o u i s          | gpg public key:      |
|   http://www.bgl.nu/~glouis |   finger greg@bgl.nu |
