Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281045AbRKRITy>; Sun, 18 Nov 2001 03:19:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281210AbRKRITp>; Sun, 18 Nov 2001 03:19:45 -0500
Received: from fwppp34.fastwave.net ([209.77.31.193]:4225 "EHLO
	p2.alex.fastwave.net") by vger.kernel.org with ESMTP
	id <S281045AbRKRIT2>; Sun, 18 Nov 2001 03:19:28 -0500
Subject: 15pre6 omits drivers/usb/serial
To: linux-kernel@vger.kernel.org
Date: Sun, 18 Nov 2001 00:19:10 -0800 (PST)
X-Mailer: ELM [version 2.4ME+ PL89 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Message-Id: <E165NAU-0000LQ-00@p2.alex.fastwave.net>
From: Alex Perry <alex.perry@ieee.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've just patched 14 to 15pre6 ... the serial driver subdirectory for USB
doesn't build modules even when requested to do so in the configuration.
I made the obvious one-line addition to the Makefile for the usb directory,
and it seems to work for me, but there may be more subtle dependency needs.

> # Subdirs.
> mod-subdirs     := serial
