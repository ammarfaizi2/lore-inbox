Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262120AbRFBXSC>; Sat, 2 Jun 2001 19:18:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262168AbRFBXRv>; Sat, 2 Jun 2001 19:17:51 -0400
Received: from oe11.law9.hotmail.com ([64.4.8.115]:27150 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S262120AbRFBXRo>;
	Sat, 2 Jun 2001 19:17:44 -0400
X-Originating-IP: [24.30.157.168]
From: "M.N." <balkanboy@hotmail.com>
To: <linux-kernel@vger.kernel.org>
Subject: is a kernel panic supposed to happen if root fs is on a SCSI disk and SCSI support is compiled in as module?
Date: Sat, 2 Jun 2001 16:17:32 -0700
MIME-Version: 1.0
Content-Type: text/plain;	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MIMEOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Message-ID: <OE11ur2iz2Mb1s7nlT200005c9b@hotmail.com>
X-OriginalArrivalTime: 02 Jun 2001 23:17:38.0156 (UTC) FILETIME=[36C2E2C0:01C0EBBA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Basically, that's the question. I compiled my kernel with the SCSI AIC7xxx.o
driver as a module, and then when it booted up, it paniced. I thought it was
some sort of a kernel bug, but it didn't really seem that way when I
recompiled the kernel with SCSI support built-in in the kernel itself
(monolithically).  I'm just curious, does a _panic_ necessarily mean that
the kernel needs fixing, or can a panic be a result of something that the
user forgot to do which was required in order to avoid that panic?

Thanks.
Martin
