Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261277AbSJPRhF>; Wed, 16 Oct 2002 13:37:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261290AbSJPRhF>; Wed, 16 Oct 2002 13:37:05 -0400
Received: from fastmail.fm ([209.61.183.86]:24020 "EHLO www.fastmail.fm")
	by vger.kernel.org with ESMTP id <S261277AbSJPRhE>;
	Wed, 16 Oct 2002 13:37:04 -0400
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="ISO-8859-1"
MIME-Version: 1.0
X-Mailer: MIME::Lite 1.2  (F2.6; T1.001; A1.50; B2.12; Q2.03)
Date: Wed, 16 Oct 2002 17:42:48 UT
From: "Aravind Ceyardass" <aravind1001@speedpost.net>
To: linux-kernel@vger.kernel.org
X-Epoch: 1034790176
X-Sasl-enc: NjAUUkYmlEvhgfPPUel2Ng
Subject: Gcc and regparm
Message-Id: <20021016174248.C34811AEC146@server5.fastmail.fm>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hi,

Gcc 3.2 doesn't honours the regparm attribute for FASTCALL in
asm-i386/linkage.h
while compiling modules. It assumes regparm(0) instead of regparm(3) and
generates
incompatible code for modules. I have tried gcc 2.96-x and gcc 3.2. I
have upgraded my binutils.
Still the problem persists. Tried searching the Net for right gcc
version. But could not find any information. 

Could anyone send me some info on gcc and binutils versions?

Thanks in advance

Aravind


-- 
http://fastmail.fm - The way an email service should be
