Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261390AbVBKSEM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261390AbVBKSEM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 13:04:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262076AbVBKSEM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 13:04:12 -0500
Received: from mail.linicks.net ([217.204.244.146]:53132 "EHLO
	linux233.linicks.net") by vger.kernel.org with ESMTP
	id S261390AbVBKSEI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 13:04:08 -0500
From: Nick Warne <nick@linicks.net>
To: linux-kernel@vger.kernel.org
Subject: Re: How to disable slow agpgart in kernel config?
Date: Fri, 11 Feb 2005 18:04:06 +0000
User-Agent: KMail/1.7.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502111804.06899.nick@linicks.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > This surprises me, especially considering the in-kernel nvidia-agp driver
> > was actually written by NVidia. Are there any agp error messages in
> > your dmesg / X log ?

> With the nVidia own nv_agp it appears directly in all apps, very fast 
> under GNOME 2.8.1. Why, I do not know. Also game (opengl) performance is 
> faster with the nv_agp, that I haven't used the kernel agp for months, now.

This is interesting.  I always used agpgart without a second thought (2.4.29, 
GeForce4 MX with Via KT133 chipset).

I just read through the nVidia readme file, and there is a comprehensive 
section on what module to use for what chipset (and card).  It recommends 
using the nVagp for my setup, so I just rebuilt excluding agpgart so I can 
use the nVdia module.

I never had slowness as such in KDE or X apps, but playing quake2 openGL I 
used to get a 'wave' type effect rippling down the screen occasionally.  A 
quick test using the nVagp module to have fixed that...

I will test for a few weeks.

Nick
-- 
"When you're chewing on life's gristle,
Don't grumble, Give a whistle..."
