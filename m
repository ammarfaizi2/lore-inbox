Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932087AbWATW3Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932087AbWATW3Q (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 17:29:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932247AbWATW3Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 17:29:16 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:21778 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932087AbWATW3Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 17:29:16 -0500
Date: Fri, 20 Jan 2006 23:29:15 +0100
From: Adrian Bunk <bunk@stusta.de>
To: perex@suse.cz
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
       Lukasz Stemach <stelmacl@ee.pw.edu.pl>
Subject: [2.6 patch] sound/isa/cs423x/cs4236.c: PnP ids for Netfinity 3000
Message-ID: <20060120222914.GD31803@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lukasz Stemach <stelmacl@ee.pw.edu.pl>


PnP ids for Netfinity 3000 builtin soundcard.

This one works for me.


This patch was submitted through kernel Bugzilla #4214.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- l/sound/isa/cs423x/cs4236.c.orig	2004-10-23 10:54:33.000000000 +0200
+++ l/sound/isa/cs423x/cs4236.c	2004-12-27 01:01:31.000000000 +0100
@@ -174,6 +173,8 @@
 	{ .id = "CSC7632", .devs = { { "CSC0000" }, { "CSC0010" }, { "PNPb006" } } },
 	/* SIC CrystalWave 32 (CS4232) */
 	{ .id = "CSCf032", .devs = { { "CSC0000" }, { "CSC0010" }, { "CSC0003" } } },
+	/* Netfinity 3000 on-board soundcard */
+	{ .id = "CSCe825", .devs = { { "CSC0100" }, { "CSC0110" }, { "CSC010f" } } },
 	/* --- */
 	{ .id = "" }	/* end */
 };

