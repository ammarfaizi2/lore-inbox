Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135225AbRDWOeL>; Mon, 23 Apr 2001 10:34:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135239AbRDWOeC>; Mon, 23 Apr 2001 10:34:02 -0400
Received: from cm.med.3284844210.kabelnet.net ([195.202.190.178]:12036 "EHLO
	phobos.hvrlab.org") by vger.kernel.org with ESMTP
	id <S135225AbRDWOdy>; Mon, 23 Apr 2001 10:33:54 -0400
Date: Mon, 23 Apr 2001 16:33:38 +0200
Message-Id: <200104231433.QAA05348@phobos.hvrlab.org>
From: Herbert Valerio Riedel <hvr@gnu.org>
To: linux-crypto@nl.linux.org
Subject: Announce: cryptoapi-2.4.3 [aka international crypto (non-)patch]
CC: linux-kernel@vger.kernel.org, ak@suse.de, axboe@suse.de, astor@fast.no,
        hvr@gnu.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello!

short version:
   this is the international crypto patch, which is built outside of
   the kernel source tree. you don't even have to reboot (unless your
   kernel didn't have loop devices enabled, or some other unthought
   situation exists... :)

As a response to Jari's loop-AES crypto filter for the loop back
device, which claims to be hassle free since no kernel modification is
needed; I've repackaged the all known international crypto patch,
which according to some people suffers from the need to patch the
kernel in order to make use of it and thus may not be ever get into
the kernel since there are still some countries where laws don't
support an individuals need for privacy.

This (re)package has only one major drawback, crypto can only built as
modules so far and it supports only kernel 2.4.3 and later so far... 

If you are interested you can get it from

http://www.hvrlab.org/pub/crypto/cryptoapi-2.4.3-hvr4.tar.gz

...as usual, backup your data before playing around with it... :-)

ps: there is an optional patch against loop.[ch] contained, which
fixes current IV calculation bugs and introduces a selectable sector
based IV calculation mode.

greetings,
-- 
Herbert Valerio Riedel      /     Finger hvr@gnu.org for GnuPG Public Key
GnuPG Key Fingerprint: 7BB9 2D6C D485 CE64 4748  5F65 4981 E064 883F 4142

