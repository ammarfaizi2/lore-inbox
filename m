Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284969AbRLZWIc>; Wed, 26 Dec 2001 17:08:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284966AbRLZWIR>; Wed, 26 Dec 2001 17:08:17 -0500
Received: from mail000.mail.bellsouth.net ([205.152.58.20]:7299 "EHLO
	imf00bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S284965AbRLZWID>; Wed, 26 Dec 2001 17:08:03 -0500
Subject: 2.4.18-pre1 compile error
From: Louis Garcia <louisg00@bellsouth.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 26 Dec 2001 17:10:22 -0500
Message-Id: <1009404628.24101.0.camel@tiger>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Compiling broke with radeonfb.c:


radeonfb.c: In function 'radeon_save_state':
radeonfb.c:2283: TMOS_TRANSMITTER_CNTL' undeclared (first use in this
function)
radeonfb.c:2283: (Each undeclared identifier is reported only once
radeonfb.c:2283: for each function it appears in.)
radeonfb.c: In function 'radeon_load_video_mode':
radeonfb.c:2560: 'TMOS_RAN_PAT_RST' undeclared (first use in this
function)
radeonfb.c:2561: 'ICHCSEL' undeclared (first use in this function)
radeonfb.c:2561: 'TMOS_PLLRST' undeclared (first use in this function)
radeonfb.c: In function 'radeon_write_mode':
radeonfb.c:2650: 'TMOS_TRANSMITTER_CNTL' undeclared (first use in this
function)
radeonfb.c:2655: 'LVDS_STATE_MASK' undeclared (first use in this
function)
radeonfb.c: At top level:
radeonfb.c:2957: warning: 'fbcon_radeon8' defined but not used
make[3]: *** [radeonfb.o] Error 1


I am not subscribed to the list. If a patch is floating around please
email me.

Thanks,  --Louis




