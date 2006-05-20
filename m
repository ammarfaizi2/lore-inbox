Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932379AbWETVhi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932379AbWETVhi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 May 2006 17:37:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932384AbWETVhi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 May 2006 17:37:38 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:22747 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S932379AbWETVhh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 May 2006 17:37:37 -0400
Date: Sat, 20 May 2006 23:37:36 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: John Richard Moser <nigelenki@comcast.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: IA-32 on x86-64
In-Reply-To: <446F138F.4020801@comcast.net>
Message-ID: <Pine.LNX.4.61.0605202335170.27403@yvahk01.tjqt.qr>
References: <446F138F.4020801@comcast.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>Does anyone know how to check if I'm running an IA-32 process on x86-64?

printf("%d\n", sizeof(void *)) should report 4 with 32-bit code.

> More importantly, how do I tell how big the user VM space is for
>current?

Find the bottom address of the stack. (This is left as an exercise.)


Jan Engelhardt
-- 
