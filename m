Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261959AbTKMCvD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Nov 2003 21:51:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261965AbTKMCvC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Nov 2003 21:51:02 -0500
Received: from pentafluge.infradead.org ([213.86.99.235]:33986 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261959AbTKMCvB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Nov 2003 21:51:01 -0500
Subject: Re: List of SCO files
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Dax Kelson <dax@gurulabs.com>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <1068679942.3082.131.camel@mentor.gurulabs.com>
References: <1068679942.3082.131.camel@mentor.gurulabs.com>
Content-Type: text/plain
Message-Id: <1068691791.13135.41.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 13 Nov 2003 13:49:51 +1100
Content-Transfer-Encoding: 7bit
X-SA-Exim-Mail-From: benh@kernel.crashing.org
X-SA-Exim-Scanned: No; SAEximRunCond expanded to false
X-Pentafluge-Mail-From: <benh@kernel.crashing.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Or just include/asm-m68k/spinlock.h :)

The whole file is just:

#ifndef __M68K_SPINLOCK_H
#define __M68K_SPINLOCK_H
 
#error "m68k doesn't do SMP yet"
 
#endif


