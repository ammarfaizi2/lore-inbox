Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261967AbUA3J6j (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 04:58:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261775AbUA3J6j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 04:58:39 -0500
Received: from chico.rediris.es ([130.206.1.3]:11924 "EHLO chico.rediris.es")
	by vger.kernel.org with ESMTP id S261967AbUA3J6h convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 04:58:37 -0500
From: David =?iso-8859-1?q?Mart=EDnez=20Moreno?= <ender@debian.org>
Organization: Debian
To: Greg KH <greg@kroah.com>
Subject: Re: Typo (Re: [PATCH] i2c driver fixes for 2.6.2-rc2)
Date: Fri, 30 Jan 2004 10:58:29 +0100
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
References: <10752464532256@kroah.com> <200401291227.15413.ender@debian.org> <20040129194705.GD5681@kroah.com>
In-Reply-To: <20040129194705.GD5681@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200401301058.29324.ender@debian.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Jueves, 29 de Enero de 2004 20:47, Greg KH escribió:
> On Thu, Jan 29, 2004 at 12:27:15PM +0100, David Martínez Moreno wrote:
> > 	Sure, it's only a small thing in return for all that Linux has given to
> > me.
> >
> > 	Following patch fixes two typos and a missing full stop. Applies cleanly
> > against 2.6.2-rc2 + i2c patches you just submitted.
>
> Hm, your mailer munged the patch (due to the PGP signature), care to
> redo it so that it can be applied?

	I agree. :-)

	There goes again, without GPG sig.

	Following patch fixes two typos and a missing full stop. Applies cleanly
against 2.6.2-rc2 + i2c patches you just submitted.

--- kernel-2.6.x/drivers/i2c/chips/lm85.c.orig	2004-01-29 12:18:49.000000000 +0100
+++ kernel-2.6.x/drivers/i2c/chips/lm85.c	2004-01-29 12:21:01.000000000 +0100
@@ -816,7 +816,7 @@
 			kind = lm85b ;
 		} else if( company == LM85_COMPANY_NATIONAL
 		    && (verstep & 0xf0) == LM85_VERSTEP_GENERIC ) {
-			dev_err(&adapter->dev, "Unrecgonized version/stepping 0x%02x"
+			dev_err(&adapter->dev, "Unrecognized version/stepping 0x%02x"
 				" Defaulting to LM85.\n", verstep);
 			kind = any_chip ;
 		} else if( company == LM85_COMPANY_ANALOG_DEV
@@ -827,7 +827,7 @@
 			kind = adt7463 ;
 		} else if( company == LM85_COMPANY_ANALOG_DEV
 		    && (verstep & 0xf0) == LM85_VERSTEP_GENERIC ) {
-			dev_err(&adapter->dev, "Unrecgonized version/stepping 0x%02x"
+			dev_err(&adapter->dev, "Unrecognized version/stepping 0x%02x"
 				" Defaulting to ADM1027.\n", verstep);
 			kind = adm1027 ;
 		} else if( kind == 0 && (verstep & 0xf0) == 0x60) {
@@ -1204,7 +1204,7 @@
 
 /* Thanks to Richard Barrington for adding the LM85 to sensors-detect.
  * Thanks to Margit Schubert-While <margitsw@t-online.de> for help with
- *     post 2.7.0 CVS changes
+ *     post 2.7.0 CVS changes.
  */
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Philip Pokorny <ppokorny@penguincomputing.com>, Margit Schubert-While <margitsw@t-online.de>");


	Regards,


		Ender.
-- 
Oh, I saw...Very American. Fire enough bullets and hope
 they hit the target!
		-- Allan Quatermain (The League of Extraordinary Gentlemen)
--
Servicios de red - Network services
RedIRIS - Spanish Academic Network for Research and Development
Madrid (Spain)
Tlf (+34) 91.585.51.50

