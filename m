Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263272AbVFXL6v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263272AbVFXL6v (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 07:58:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263267AbVFXL6u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 07:58:50 -0400
Received: from hulk.hostingexpert.com ([69.57.134.39]:35264 "EHLO
	hulk.hostingexpert.com") by vger.kernel.org with ESMTP
	id S263262AbVFXLxR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 07:53:17 -0400
Message-ID: <42BBF454.2040305@m1k.net>
Date: Fri, 24 Jun 2005 07:53:56 -0400
From: Michael Krufky <mkrufky@m1k.net>
Reply-To: mkrufky@m1k.net
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: mkrufky@m1k.net
CC: video4linux-list@redhat.com, linux-kernel@vger.kernel.org
Subject: [GIT PATCH] remove tuner constant declared twice in /linux/include/media/tuner.h
References: <42BBEF45.6000301@m1k.net>
In-Reply-To: <42BBEF45.6000301@m1k.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hulk.hostingexpert.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - m1k.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Krufky wrote:

> Linus-
>
> I reviewed -git6 this morning, and I noticed that a constant is 
> declared twice for tuner #60 in /linux/include/media/tuner.h
>
> This patch removes the second entry.  This has already been corrected 
> in -mm by a later patch.
>
> Thank you.
>
> Signed-off-by: Michael Krufky <mkrufky@m1k.net>
>
>------------------------------------------------------------------------
>
>diff -upr linux-2.6.12-git6/include/media/tuner.h linux/include/media/tuner.h
>--- linux-2.6.12-git6/include/media/tuner.h	2005-06-24 07:16:35.000000000 +0000
>+++ linux/include/media/tuner.h	2005-06-24 07:18:03.000000000 +0000
>@@ -108,8 +108,6 @@
> 
> #define TEA5767_TUNER_NAME "Philips TEA5767HN FM Radio"
> 
>-#define TUNER_THOMSON_DTT7611    60
>-
> #define NOTUNER 0
> #define PAL     1	/* PAL_BG */
> #define PAL_I   2
>  
>
I sent this to Linus this morning and forgot to CC the lists... This is 
a very minor change, if he doesn't accept it, things will work the same 
just as well.

-- 
Michael Krufky

