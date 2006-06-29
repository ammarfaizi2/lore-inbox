Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932070AbWF2UT0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932070AbWF2UT0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 16:19:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932408AbWF2UT0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 16:19:26 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:2466 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932070AbWF2UTZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 16:19:25 -0400
Subject: Re: [v4l-dvb-maintainer] [2.6 patch] VIDEO_V4L1 shouldn't be
	user-visible
From: Mauro Carvalho Chehab <mchehab@infradead.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: v4l-dvb-maintainer@linuxtv.org, linux-kernel@vger.kernel.org
In-Reply-To: <20060629192124.GD19712@stusta.de>
References: <20060629192124.GD19712@stusta.de>
Content-Type: text/plain; charset=ISO-8859-1
Date: Thu, 29 Jun 2006 17:18:37 -0300
Message-Id: <1151612317.3728.34.camel@praia>
Mime-Version: 1.0
X-Mailer: Evolution 2.7.2.1-4mdv2007.0 
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian,

Em Qui, 2006-06-29 às 21:21 +0200, Adrian Bunk escreveu:
> VIDEO_V4L1 is an implementation detail that shouldn't be user-visible.

Nack. 

V4L1 is an obsolete api, just like OSS, marked at
feature-removal-schedule.txt to be removed on July (probably, we might
need to postpone this, but this is another question). 

This API have serious trouble on handling video and audio standards used
on analog world and should be discontinued in favor of V4L2 API. Like
ALSA have, V4L2 drivers also have a compatibility driver that changes
calls from legacy userspace applications into newer V4L2 calls (of
course losing several features, working fine only for a few video
standards that were supported by V4L1).

Cheers, 
Mauro.

