Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261846AbVCOTyz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261846AbVCOTyz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 14:54:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261836AbVCOTvr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 14:51:47 -0500
Received: from chello081018222206.chello.pl ([81.18.222.206]:45575 "EHLO
	plus.ds14.agh.edu.pl") by vger.kernel.org with ESMTP
	id S261823AbVCOTtb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 14:49:31 -0500
From: =?utf-8?q?Pawe=C5=82_Sikora?= <pluto@pld-linux.org>
To: Stephen Evanchik <evanchsa@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.11] IBM TrackPoint support
Date: Tue, 15 Mar 2005 20:49:25 +0100
User-Agent: KMail/1.8
References: <a71293c2050313210230161278@mail.gmail.com>
In-Reply-To: <a71293c2050313210230161278@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_GxzNCuiaxBlMfeP"
Message-Id: <200503152049.26488.pluto@pld-linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_GxzNCuiaxBlMfeP
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Monday 14 of March 2005 06:02, Stephen Evanchik wrote:
> Here's the latest patch for TracKPoint devices. I have changed the
> sysfs filenames to be more descriptive for commonly used attributes. I
> also implemented the set_properties flag for initialization.
>
> It patches against 2.6.11 and 2.6.11.3 however I have not tested it
> with 2.6.11.3 .
>
> Any comments are appreciated.

  CC [M]  drivers/input/mouse/psmouse-base.o
drivers/input/mouse/psmouse-base.c: In function 'psmouse_extensions':
drivers/input/mouse/psmouse-base.c:489: error: 'PSMOUSE_TRACKPOINT' undeclared

;-)

-- 
/* Copyright (C) 2003, SCO, Inc. This is valuable Intellectual Property. */

                           #define say(x) lie(x)

--Boundary-00=_GxzNCuiaxBlMfeP
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="1.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="1.diff"

--- linux-2.6.11.3/drivers/input/mouse/psmouse.h.orig	2005-03-15 20:22:45.000000000 +0100
+++ linux-2.6.11.3/drivers/input/mouse/psmouse.h	2005-03-15 20:47:12.000000000 +0100
@@ -79,6 +79,7 @@
 	PSMOUSE_IMEX,
 	PSMOUSE_SYNAPTICS,
 	PSMOUSE_ALPS,
+	PSMOUSE_TRACKPOINT,
 };
 
 int psmouse_sliced_command(struct psmouse *psmouse, unsigned char command);

--Boundary-00=_GxzNCuiaxBlMfeP--
