Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264361AbRF2Ssy>; Fri, 29 Jun 2001 14:48:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266154AbRF2Sso>; Fri, 29 Jun 2001 14:48:44 -0400
Received: from tomts7.bellnexxia.net ([209.226.175.40]:25033 "EHLO
	tomts7-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S266153AbRF2Ssi>; Fri, 29 Jun 2001 14:48:38 -0400
Content-Type: text/plain; charset=US-ASCII
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: linux-kernel@vger.kernel.org
Subject: cs46xx and 2.4.6-pre6
Date: Fri, 29 Jun 2001 14:48:27 -0400
X-Mailer: KMail [version 1.2]
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
MIME-Version: 1.0
Message-Id: <01062914482700.03759@oscar>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Suspect the 

#define CS46XX_APCI_SUPPORT 1

found in cs46xxpm-24.h is bogus.  With it defined I can conflicts between it an cs46xx.c
with cs46xx_suspend_tlb and cs46xx_resume_tbl

Removed the #define and the module built.

Ed Tomlinson

