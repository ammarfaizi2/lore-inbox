Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932136AbWDLKXz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932136AbWDLKXz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Apr 2006 06:23:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932137AbWDLKXz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Apr 2006 06:23:55 -0400
Received: from newton.linux4geeks.de ([193.30.1.1]:60332 "EHLO
	newton.linux4geeks.de") by vger.kernel.org with ESMTP
	id S932136AbWDLKXz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Apr 2006 06:23:55 -0400
Date: Wed, 12 Apr 2006 12:23:52 +0200 (CEST)
From: Sven Ladegast <sven@linux4geeks.de>
To: linux-kernel@vger.kernel.org
Subject: latency problems with kernel >= 2.6.15 and glibc 2.3.6
Message-ID: <Pine.LNX.4.63.0604121140030.2821@cassini.linux4geeks.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello folks,

I am experiencing latency problems with kernels above 2.6.15 and my self-compiled system.
I am using glibc 2.3.6 (pthreads + libidn) compiled against kernel 2.6.12 headers.

If a process needs 100% CPU power the latency is becoming terrible. If i 
nice that process to a lower priority effects are not that strong. 
Especially working with a web browser displaying a website where multiple 
flashplayer-plugins were startet the system is almost unusable. Input 
events are not catched, mouse and sounds stuck and so on...

Preemption model is "low-latency-desktop", 
CONFIG_PREEMPT_BKL: 1
CONFIG_HZ: 1000

Has anyone experienced similar problems?

Sven
-- 
www.linux4geeks.de
