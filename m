Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312393AbSDXRMT>; Wed, 24 Apr 2002 13:12:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312413AbSDXRMS>; Wed, 24 Apr 2002 13:12:18 -0400
Received: from chaos.analogic.com ([204.178.40.224]:640 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S312393AbSDXRMR>; Wed, 24 Apr 2002 13:12:17 -0400
Date: Wed, 24 Apr 2002 13:12:16 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Serial I/O Screwed UP
Message-ID: <Pine.LNX.3.95.1020424130910.543A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linux Version 2.4.18 fails to open the same device-majors as
previous versions when attempting to open /dev/ttyS0, and
/dev/ttyS1.

Apparently something is done out-of-order. It's in an  embedded
system so I can't attempt to open other device-majors in an attempt
to find where they put the first serial port.

Does anybody have a fix?

Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (797.90 BogoMips).

                 Windows-2000/Professional isn't.

