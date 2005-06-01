Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261306AbVFAV0f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261306AbVFAV0f (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 17:26:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261195AbVFAVZ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 17:25:57 -0400
Received: from smtp2.brturbo.com.br ([200.199.201.158]:19361 "EHLO
	smtp2.brturbo.com.br") by vger.kernel.org with ESMTP
	id S261313AbVFAVYf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 17:24:35 -0400
Message-ID: <429E2792.7000700@brturbo.com.br>
Date: Wed, 01 Jun 2005 18:24:34 -0300
From: Mauro Carvalho Chehab <mchehab@brturbo.com.br>
User-Agent: Mozilla Thunderbird 1.0.2-3mdk (X11/20050322)
X-Accept-Language: pt-br, pt, es, en-us, en
MIME-Version: 1.0
CC: linux-kernel@vger.kernel.org
Subject: Fwd: [PATCH] tuner-core.c improvments and Ymec Tvision TVF8533MF
 support]
X-Enigmail-Version: 0.91.0.0
Content-Type: multipart/mixed;
 boundary="------------090303070604030500080306"
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090303070604030500080306
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Sorry, I forgot to attach the file :-)

-------- Original Message --------

tuner-core.c, tuner.h:

        - tuner-core changed to support multiple I2C devices used on
some adapters;
        - Kconfig now has an option (CONFIG_TUNER_MULTI_I2C) to enable
this new behavor;
        - By default, even enabling CONFIG_TUNER_MULTI_I2C, tuner-core
emulates the old behavor,  using first I2C device for both FM and TV;
        - There is a new i2c command (TUNER_SET_ADDR) to allow tuner
clients to select I2C address for FM or TV tuner;
        - Tuner I2C dettach now generates a warning on syslog if failed.

tuner-simple.c:
        - TVision TVF-8531MF and TVF-5533 MF tuner included. It uses, by
default, I2C on 0xC2 address for TV and on 0xC0 for Radio. Both TV and
FM Radio mode are working.

Signed-off-by: Mauro Carvalho Chehab <mchehab@brturbo.com.br>



--------------090303070604030500080306
Content-Type: text/plain;
 name="file:///home/mchehab/tmp/nsmail-1.asc"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="file:///home/mchehab/tmp/nsmail-1.asc"

--
video4linux-list mailing list
Unsubscribe mailto:video4linux-list-request@redhat.com?subject=unsubscribe
https://www.redhat.com/mailman/listinfo/video4linux-list

--------------090303070604030500080306--
