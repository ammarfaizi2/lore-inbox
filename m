Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932150AbWA3JMS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932150AbWA3JMS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 04:12:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932152AbWA3JMS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 04:12:18 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:22916 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S932150AbWA3JMR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 04:12:17 -0500
Date: Mon, 30 Jan 2006 10:11:35 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Adrian Bunk <bunk@stusta.de>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [2.6 patch] make CONFIG_SECCOMP default to n
In-Reply-To: <20060128230452.GV3777@stusta.de>
Message-ID: <Pine.LNX.4.61.0601301009550.6405@yvahk01.tjqt.qr>
References: <20060128230452.GV3777@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>i was profiling the scheduler on x86 and noticed some overhead related 
>to SECCOMP, and indeed, SECCOMP runs disable_tsc() at _every_ 
>context-switch:

Does this also apply to processes not having changed into seccomp mode yet?


Jan Engelhardt
-- 
| Software Engineer and Linux/Unix Network Administrator
| Alphagate Systems, http://alphagate.hopto.org/
| jengelh's site, http://jengelh.hopto.org/
