Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262687AbUKRADH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262687AbUKRADH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 19:03:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262683AbUKRABV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 19:01:21 -0500
Received: from vsmtp14.tin.it ([212.216.176.118]:30956 "EHLO vsmtp14.tin.it")
	by vger.kernel.org with ESMTP id S262619AbUKQX66 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 18:58:58 -0500
Subject: [PATCH] drivers/video/gbefb.c
From: Giuseppe Sacco <giuseppe@eppesuigoccas.homedns.org>
To: lkml <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-PgfIMXWlsK78DCnoIbed"
Organization: Giuseppe Sacco Consulting
Date: Thu, 18 Nov 2004 00:58:37 +0100
Message-Id: <1100735917.7866.11.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-PgfIMXWlsK78DCnoIbed
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

The current gbefb.c source cannot be compiled as module because of a
small typo where "option" was written instead of "options" in two
places.

Here is a small patch that fixes it. May anyone apply it?

Thanks,
Giuseppe

--=-PgfIMXWlsK78DCnoIbed
Content-Description: 
Content-Disposition: inline; filename=drivers.video.gbefb.c.diff
Content-Type: text/x-patch; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Index: gbefb.c
===================================================================
RCS file: /home/cvs/linux/drivers/video/gbefb.c,v
retrieving revision 1.11
diff -r1.11 gbefb.c
1121c1121
< 	char *option = NULL;
---
> 	char *options = NULL;
1123c1123
< 	if (fb_get_options("gbefb", &option))
---
> 	if (fb_get_options("gbefb", &options))

--=-PgfIMXWlsK78DCnoIbed--

