Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267270AbSLKTBA>; Wed, 11 Dec 2002 14:01:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267271AbSLKTBA>; Wed, 11 Dec 2002 14:01:00 -0500
Received: from mailout01.sul.t-online.com ([194.25.134.80]:48618 "EHLO
	mailout01.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S267270AbSLKTA6>; Wed, 11 Dec 2002 14:00:58 -0500
Message-Id: <4.3.2.7.2.20021211200359.00b5adb0@pop.t-online.de>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Wed, 11 Dec 2002 20:09:12 +0100
To: linux-kernel@vger.kernel.org
From: margitsw@t-online.de (Margit Schubert-While)
Subject: RE: [Dri-devel] Re: 2.4.20 AGP for I845 wrong ?
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 >Keith Whitwell wrote:
 >diff -u -r1.9 drm_agpsupport.h
 >--- drm_agpsupport.h	22 Aug 2002 19:35:31 -0000	1.9
 >+++ drm_agpsupport.h	11 Dec 2002 13:29:18 -0000
 >@@ -260,60 +260,6 @@
 > 			return NULL;
 > 		}
 > 		head->memory = NULL;
 >-		switch (head->agp_info.chipset) {
 >-		case INTEL_GENERIC:	head->chipset = "Intel";         break;

Think you missed something at line 258.

Margit 

