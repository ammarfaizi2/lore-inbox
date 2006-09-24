Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751011AbWIXL4w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751011AbWIXL4w (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 07:56:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751211AbWIXL4v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 07:56:51 -0400
Received: from max.feld.cvut.cz ([147.32.192.36]:8419 "EHLO max.feld.cvut.cz")
	by vger.kernel.org with ESMTP id S1751011AbWIXL4v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 07:56:51 -0400
From: CIJOML <cijoml@volny.cz>
To: linux-kernel@vger.kernel.org, Petr Baudis <pasky@ucw.cz>
Subject: Re: patch remove hostap debug code from standard compile mode
Date: Sun, 24 Sep 2006 13:56:51 +0200
User-Agent: KMail/1.9.3
References: <200609232242.31465.cijoml@volny.cz> <20060924003727.GD11916@pasky.or.cz>
In-Reply-To: <20060924003727.GD11916@pasky.or.cz>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_DKnFFz/xXmFS8gc"
Message-Id: <200609241356.51397.cijoml@volny.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_DKnFFz/xXmFS8gc
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

ah! Thanks resending

Michal

Dne ned=ECle 24 z=E1=F8=ED 2006 02:37 Petr Baudis napsal(a):
>   Hi,
>
> Dear diary, on Sat, Sep 23, 2006 at 10:42:31PM CEST, I got a letter
> where CIJOML <cijoml@volny.cz> said that...
>
> > I think we don't want have debug messages running hostap drivers in
> > normal operations until we have option in menu to select debug mode.
> >
> > Michal
> >
> > Please include:
> >
> > --- linux-2.6.18/drivers/net/wireless/hostap/hostap_config.h.orig
> > 2006-09-20 05:42:06.000000000 +0200
> > +++ linux-2.6.18/drivers/net/wireless/hostap/hostap_config.h  =20
> > 2006-09-23 22:30:50.000000000 +0200
> > @@ -38,10 +38,10 @@
> >   */
> >
> >  /* Do not include debug messages into the driver */
> > -/* #define PRISM2_NO_DEBUG */
> > +#define PRISM2_NO_DEBUG
> >
> >  /* Do not include /proc/net/prism2/wlan#/{registers,debug} */
> > -/* #define PRISM2_NO_PROCFS_DEBUG */
> > +#define PRISM2_NO_PROCFS_DEBUG
> >
> >  /* Do not include station functionality (i.e., allow only Master (Host
> > AP) mode
> >   */
>
>   JFYI, your patch got linewrapped.

--Boundary-00=_DKnFFz/xXmFS8gc
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="patch_hostap"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="patch_hostap"

--- linux-2.6.18/drivers/net/wireless/hostap/hostap_config.h.orig       2006-09-20 05:42:06.000000000 +0200
+++ linux-2.6.18/drivers/net/wireless/hostap/hostap_config.h    2006-09-23 22:30:50.000000000 +0200
@@ -38,10 +38,10 @@
  */

 /* Do not include debug messages into the driver */
-/* #define PRISM2_NO_DEBUG */
+#define PRISM2_NO_DEBUG

 /* Do not include /proc/net/prism2/wlan#/{registers,debug} */
-/* #define PRISM2_NO_PROCFS_DEBUG */
+#define PRISM2_NO_PROCFS_DEBUG

 /* Do not include station functionality (i.e., allow only Master (Host AP) mode
  */


--Boundary-00=_DKnFFz/xXmFS8gc--
