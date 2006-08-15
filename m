Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965190AbWHOGK1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965190AbWHOGK1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 02:10:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965189AbWHOGK1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 02:10:27 -0400
Received: from pne-smtpout2-sn1.fre.skanova.net ([81.228.11.159]:13959 "EHLO
	pne-smtpout2-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S965106AbWHOGK0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 02:10:26 -0400
Date: Tue, 15 Aug 2006 08:06:18 +0200
From: Martin Samuelsson <sam@home.se>
To: Adrian Bunk <bunk@stusta.de>
Cc: mchehab@infradead.org, v4l-dvb-maintainer@linuxtv.org,
       linux-kernel@vger.kernel.org
Subject: Re: drivers/media/video/bt866.c: array overflows
Message-Id: <20060815080618.50200f6b.sam@home.se>
In-Reply-To: <20060814232337.GZ3543@stusta.de>
References: <20060814232337.GZ3543@stusta.de>
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.20; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Aug 2006 01:23:37 +0200
Adrian Bunk <bunk@stusta.de> wrote:

> The Coverity checker spotted the following two array overflows:

Nice coverity checker! *pat pat*

Now, a question: Where can I find the latest version of the files that concern the avs6eyes driver? In april, I got this mail that informed me that the avs6eyes driver patch had been removed from the -mm tree. I figured that it was removed because of the lack of internal V4L2 support when V4L1 was about to be chucked out from the kernel. I looked around a little to see if I could find the driver, but I couldn't.

Obviously, as you've found bugs in it, I didn't look in the right places. Where, pray tell, did the little critter go?

Getting a new job and moving to another city has hampered me in my efforts to work on the driver, that's why I've been so quiet.

> The two bugs are obvious:
>   0xdc = 220 >= 128

Gotta fix that. Good work.

/Sam
