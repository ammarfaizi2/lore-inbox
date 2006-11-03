Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753139AbWKCGcg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753139AbWKCGcg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 01:32:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753140AbWKCGcg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 01:32:36 -0500
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:16532 "EHLO
	smtp.drzeus.cx") by vger.kernel.org with ESMTP id S1753139AbWKCGcf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 01:32:35 -0500
Message-ID: <454AE285.4070504@drzeus.cx>
Date: Fri, 03 Nov 2006 07:32:37 +0100
From: Pierre Ossman <drzeus-mmc@drzeus.cx>
User-Agent: Thunderbird 1.5.0.7 (X11/20061027)
MIME-Version: 1.0
To: Fabio Comolli <fabio.comolli@gmail.com>
CC: kernel list <linux-kernel@vger.kernel.org>, Alex Dubov <oakad@yahoo.com>
Subject: Re: 2.6.19-rc4 - tifm_7xx1 does not work after suspend-to-disk
References: <b637ec0b0611021401x2548b194s249b5d33aad782e4@mail.gmail.com>
In-Reply-To: <b637ec0b0611021401x2548b194s249b5d33aad782e4@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fabio Comolli wrote:
> Hi.
> The subject says it all: after a suspend-to-disk / resume cycle the
> FlashMedia driver does not work at all: no message is logged in the
> syslog and the SD card is not detected.

Could you enable MMC_DEBUG and see if that gives you any output? Also,
you should use "dmesg" to check as syslog misses things.

Rgds
-- 
     -- Pierre Ossman

  Linux kernel, MMC maintainer        http://www.kernel.org
  PulseAudio, core developer          http://pulseaudio.org
  rdesktop, core developer          http://www.rdesktop.org
