Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262260AbUCOF3r (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 00:29:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262265AbUCOF3r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 00:29:47 -0500
Received: from cpe-024-033-224-91.neo.rr.com ([24.33.224.91]:50049 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id S262260AbUCOF3n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 00:29:43 -0500
Date: Mon, 15 Mar 2004 00:26:07 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PnP Updates for 2.6.4-mm2
Message-ID: <20040315002607.GF5972@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20040315000615.GA5972@neo.rr.com> <20040315001029.GB5972@neo.rr.com> <20040315001519.GC5972@neo.rr.com> <20040315002146.GD5972@neo.rr.com> <20040315002357.GE5972@neo.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040315002357.GE5972@neo.rr.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[SERIAL] Add a few ids

This patch adds a few pnp ids I've been collecting for a while.

--- a/drivers/serial/8250_pnp.c	2004-03-14 23:42:34.000000000 +0000
+++ b/drivers/serial/8250_pnp.c	2004-03-14 23:43:23.000000000 +0000
@@ -266,6 +266,8 @@
 	{	"RSS00A0",		0	},
 	/* Viking 56K FAX INT */
 	{	"RSS0262",		0	},
+	/* K56 par,VV,Voice,Speakphone,AudioSpan,PnP */
+	{       "RSS0250",              0       },
 	/* SupraExpress 28.8 Data/Fax PnP modem */
 	{	"SUP1310",		0	},
 	/* SupraExpress 33.6 Data/Fax PnP modem */
@@ -283,6 +285,8 @@
 	/* 3Com Corp. */
 	/* Gateway Telepath IIvi 33.6 */
 	{	"USR0000",		0	},
+	/* U.S. Robotics Sporster 33.6K Fax INT PnP */
+	{	"USR0002",		0	},
 	/*  Sportster Vi 14.4 PnP FAX Voicemail */
 	{	"USR0004",		0	},
 	/* U.S. Robotics 33.6K Voice INT PnP */
@@ -315,6 +319,8 @@
 	{	"USR9180",		0	},
 	/* U.S. Robotics 56K Voice INT PnP*/
 	{	"USR9190",		0	},
+	/* Rockwell's (PORALiNK) 33600 INT PNP */
+	{	"WCI0003",		0	},
 	/* Unkown PnP modems */
 	{	"PNPCXXX",		UNKNOWN_DEV	},
 	/* More unkown PnP modems */
