Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266006AbSL1X3Q>; Sat, 28 Dec 2002 18:29:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266114AbSL1X3Q>; Sat, 28 Dec 2002 18:29:16 -0500
Received: from keetweej.xs4all.nl ([213.84.46.114]:128 "EHLO
	muur.intranet.vanheusden.com") by vger.kernel.org with ESMTP
	id <S266006AbSL1X3P>; Sat, 28 Dec 2002 18:29:15 -0500
From: "Folkert van Heusden" <folkert@vanheusden.com>
To: <linux-kernel@vger.kernel.org>
Subject: EINTR
Date: Sun, 29 Dec 2002 00:37:34 +0100
Message-ID: <007301c2aeca$193892c0$3640a8c0@boemboem>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2910.0)
Importance: Normal
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I always thought: you should always check for errno==EINTR when doing
read/write/recv/recvfrom/sendto.
But today I heard that when using Linux, EINTR does NEVER occur when
doing read/etc. on files.
Is this true?
And also: is this also true for sockets? and recv & friends?


Folkert van Heusden
www.vanheusden.com/Linux
