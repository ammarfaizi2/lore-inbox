Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261857AbUF0K2B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261857AbUF0K2B (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jun 2004 06:28:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261786AbUF0K2B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jun 2004 06:28:01 -0400
Received: from mail006.syd.optusnet.com.au ([211.29.132.63]:65410 "EHLO
	mail006.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261857AbUF0K1b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jun 2004 06:27:31 -0400
Date: Sun, 27 Jun 2004 20:27:16 +1000 (EST)
From: Con Kolivas <kernel@kolivas.org>
To: Michael Buesch <mbuesch@freenet.de>
cc: Willy Tarreau <willy@w.ods.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Staircase scheduler v7.4
In-Reply-To: <Pine.LNX.4.58.0406272021250.29505@kolivas.org>
Message-ID: <Pine.LNX.4.58.0406272026330.29572@kolivas.org>
References: <200406251840.46577.mbuesch@freenet.de> <200406252044.25843.mbuesch@freenet.de>
 <20040625190533.GI29808@alpha.home.local> <200406252148.37606.mbuesch@freenet.de>
 <Pine.LNX.4.58.0406272021250.29505@kolivas.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 27 Jun 2004, Con Kolivas wrote:

> 
> Ok I found a problem which alost certainly is responsible in the 
> conversion from nanoseconds to Hz and may if you're unlucky give a blank 
> timeslice. Can you try this (against staircase7.4). I'm almost certain 
> it's responsbile. 

Hmm that will be the problem but that may not compile because of the darn 
long long division thingy. I'll get a clean patch to you later on that 
does the same thing, sorry.

Con
