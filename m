Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267636AbTAQSp0>; Fri, 17 Jan 2003 13:45:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267637AbTAQSp0>; Fri, 17 Jan 2003 13:45:26 -0500
Received: from pal.q1labs.com.143.179.207.in-addr.arpa ([207.179.143.138]:22161
	"EHLO pal.q1labs.com") by vger.kernel.org with ESMTP
	id <S267636AbTAQSpZ>; Fri, 17 Jan 2003 13:45:25 -0500
Subject: CONFIG_SOUND_ICH=m does not compile ac97_audio
From: "Brian M. Hunt" <bmh@q1labs.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: Q1 Labs, Inc.
Message-Id: <1042829674.966.15.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 17 Jan 2003 14:54:34 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Compiling Linux Kernel 2.4.20
CONFIG_SOUND_ICH=m does not compile ac97_codec.o, which it depends upon.

CONFIG_SOUND_ICH is described as 'Intel ICH (i8xx), SiS 7012, NVidia
nForce Audio or AMD 768/811x'

It is listed in drivers/sound/Makefile:63
obj-$(CONFIG_SOUND_ICH)     += i810_audio.o ac97_codec.o

Some of the other sound drivers as modules that depend upon
ac97_config.o do compile it.

Please CC correspondence; I am not on the mailing list.

Cheers,
-- 
Brian M. Hunt <bmh@q1labs.com>
Cel: 506.447.9620


