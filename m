Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288325AbSAQIhq>; Thu, 17 Jan 2002 03:37:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288333AbSAQIhi>; Thu, 17 Jan 2002 03:37:38 -0500
Received: from mail.keay.uk.net ([195.224.50.100]:43788 "EHLO mail.keay.uk.net")
	by vger.kernel.org with ESMTP id <S288325AbSAQIhY>;
	Thu, 17 Jan 2002 03:37:24 -0500
Subject: Error compiling tdfxfb in 2.5.3-pre1
From: Daniel Wong <nimrod@nixhelp.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 17 Jan 2002 03:42:08 -0500
Message-Id: <1011256932.500.0.camel@stupid>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When compiling kernel 2.5.3-pre1, there is a small compile error i get
compiling tdfxfb, which could be fixed by simply changing the '-1' to 
'NODEV' (line 1978, drivers/video/tdfxfb.c).

By the way, i suspect that other framebuffer drivers may not compile.

