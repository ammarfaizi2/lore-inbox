Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751397AbWJPGtJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751397AbWJPGtJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 02:49:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751478AbWJPGtJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 02:49:09 -0400
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:57744 "EHLO
	smtp.drzeus.cx") by vger.kernel.org with ESMTP id S1751397AbWJPGtG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 02:49:06 -0400
Message-ID: <45332B5E.8010804@drzeus.cx>
Date: Mon, 16 Oct 2006 08:49:02 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Thunderbird 1.5.0.7 (X11/20061004)
MIME-Version: 1.0
To: Nick Piggin <nickpiggin@yahoo.com.au>
CC: Arjan van de Ven <arjan@infradead.org>,
       Amol Lad <amol@verismonetworks.com>,
       linux kernel <linux-kernel@vger.kernel.org>,
       kernel Janitors <kernel-janitors@lists.osdl.org>
Subject: Re: [PATCH] drivers/mmc/mmc.c: Replacing yield() with a better	alternative
References: <1160570743.19143.307.camel@amol.verismonetworks.com> <1160571491.3000.372.camel@laptopd505.fenrus.org> <452DD88E.4030707@yahoo.com.au>
In-Reply-To: <452DD88E.4030707@yahoo.com.au>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:
> 
> The condition looks broken too. It should be
> if (ms < 1000 / HZ) {...}
> 
> Shouldn't it?

Yup. I poked Russell about it ages ago, but he must have forgotten (and
admittedly, so have I). Since MMC is now on my table, I guess I should
put it on my todo list.

Rgds
-- 
     -- Pierre Ossman

  Linux kernel, MMC maintainer        http://www.kernel.org
  PulseAudio, core developer          http://pulseaudio.org
  rdesktop, core developer          http://www.rdesktop.org
  OLPC, developer                     http://www.laptop.org
