Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262026AbVGZSZL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262026AbVGZSZL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 14:25:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262018AbVGZSXg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 14:23:36 -0400
Received: from mail-in-02.arcor-online.net ([151.189.21.42]:21442 "EHLO
	mail-in-02.arcor-online.net") by vger.kernel.org with ESMTP
	id S262026AbVGZSWg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 14:22:36 -0400
Date: Tue, 26 Jul 2005 20:22:58 +0200
From: johsc@arcor.de
To: linux-kernel@vger.kernel.org
Subject: 2.4.31 panics on boot on 486 box: TSC requires pentium
Message-ID: <20050726182258.GA1719@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.4.31 compiled with -m486, panics on boot (486DX) and says something about
TSC requires pentium, bang.
enabling the obscure flag

 [*] Unsynced TSC support

seems to fix this - the corresponding .config label name is actually *more*
helpful than the documentation.


- Obscure-sound-bug
jazz16 on Travelmate 4000M doesn't seem to work either, sb.o 
complains about DSP version being "only" 3.01.

(#insmod sb type=10 io=0x220 irq={5,7} dma=1 dma16=7)

there is sound but mpg123 says 44100 is impossible.
