Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265149AbUBOSou (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Feb 2004 13:44:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265150AbUBOSou
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Feb 2004 13:44:50 -0500
Received: from libra.i-cable.com ([203.83.111.73]:24277 "HELO
	libra.i-cable.com") by vger.kernel.org with SMTP id S265149AbUBOSot
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Feb 2004 13:44:49 -0500
Message-ID: <021801c3f3f4$50f66280$353ffea9@kyle>
From: "Kyle" <kyle@southa.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: ICH5 with 2.6.1 very slow
Date: Mon, 16 Feb 2004 02:48:35 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="big5"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

today since one of my mirrored harddisk (/dev/hda) failed, I removed it from
md-raid1 and now /dev/hdc becomes /dev/hda

hdparm -t /dev/hda gets me ~37MB/s now (before: /dev/hda - 30MB/s,
/dev/hdc - 37MB/s)

maybe there's problem with /dev/hda so it's relatively slower!

However, the result still much slower than kernel 2.4.20 (55MB/s)

Kyle

