Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284776AbSAGSq2>; Mon, 7 Jan 2002 13:46:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285048AbSAGSqS>; Mon, 7 Jan 2002 13:46:18 -0500
Received: from [194.234.65.222] ([194.234.65.222]:54744 "EHLO
	mustard.heime.net") by vger.kernel.org with ESMTP
	id <S284776AbSAGSqA>; Mon, 7 Jan 2002 13:46:00 -0500
Date: Mon, 7 Jan 2002 19:45:57 +0100 (CET)
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
To: <linux-kernel@vger.kernel.org>
Subject: [BUG] Error reading multiple large files
Message-ID: <Pine.LNX.4.30.0201071941100.13561-100000@mustard.heime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all

I've sent this before, but as far as I can see, nothing's changed.

I'm having problems reading multiple large files at once. Reading 100 1GB
files at once.

What happens is, when the buffer cache gets filled up, it all stalls, and
transfer speed drops from 40-50 MB/s to a mere 2MB/s.

This has been tested on all versions from 2.4.16-2.4.18-pre1.

I've been testing Tux, Khttpd, apache 1.3.22, Apache 2, thttpd, cp and
dd to verify the bug.

Please help!

roy

--
Roy Sigurd Karlsbakk, MCSE, MCNE, CLS, LCA

Computers are like air conditioners.
They stop working when you open Windows.

