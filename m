Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261689AbTBVOw5>; Sat, 22 Feb 2003 09:52:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264631AbTBVOw4>; Sat, 22 Feb 2003 09:52:56 -0500
Received: from csl2.consultronics.on.ca ([204.138.93.2]:40917 "EHLO
	csl2.consultronics.on.ca") by vger.kernel.org with ESMTP
	id <S261689AbTBVOw4>; Sat, 22 Feb 2003 09:52:56 -0500
Date: Sat, 22 Feb 2003 10:03:01 -0500
From: Greg Louis <glouis@dynamicro.on.ca>
To: LKML <linux-kernel@vger.kernel.org>
Subject: 2.4.21pre4-ac5 aic7xxx fails to compile
Message-ID: <20030222150301.GA24497@athame.dynamicro.on.ca>
Mail-Followup-To: LKML <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Organization: Dynamicro Consulting Limited
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In file included from aic7xxx_osm.h:269,
                 from aic7xxx_osm.c:128:
aic7xxx.h:1300: parse error before *'
aic7xxx.h:1306: warning: function declaration isn't a prototype
aic7xxx_osm.c: In function `ahc_linux_fallback':
aic7xxx_osm.c:3331: `MAX_OFFSET' undeclared (first use in this function)
aic7xxx_osm.c: In function `ahc_linux_queue_recovery_cmd':
aic7xxx_osm.c:4987: `NOT_IDENTIFIED' undeclared (first use in this
function)
make[4]: *** [aic7xxx_osm.o] Error 1
make[4]: Leaving directory
/store/kernel/linux-2.4.21pre4/drivers/scsi/aic7xxx'

(Not compiled as a module; further info on request)

-- 
| G r e g  L o u i s          | gpg public key:      |
|   http://www.bgl.nu/~glouis |   finger greg@bgl.nu |
| Help free our mailboxes. Include                   |
|        http://wecanstopspam.org in your signature. |
