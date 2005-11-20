Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751208AbVKTKoE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751208AbVKTKoE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Nov 2005 05:44:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751209AbVKTKoD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Nov 2005 05:44:03 -0500
Received: from mtaout2.012.net.il ([84.95.2.4]:28127 "EHLO mtaout2.012.net.il")
	by vger.kernel.org with ESMTP id S1751208AbVKTKoB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Nov 2005 05:44:01 -0500
Date: Sun, 20 Nov 2005 12:43:43 +0200
From: Muli Ben-Yehuda <mulix@mulix.org>
Subject: Re: Inconsistent timing results of multithreaded program on an SMP
 machine.
In-reply-to: <200511202139.01299.kernel@kolivas.org>
To: Con Kolivas <kernel@kolivas.org>
Cc: Marcel Zalmanovici <MARCEL@il.ibm.com>, linux-kernel@vger.kernel.org
Message-id: <20051120104343.GC12997@granada.merseine.nu>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
References: <OF5AC87F24.6CC16082-ONC22570BF.00387722-C22570BF.0038A482@il.ibm.com>
 <200511202128.13308.kernel@kolivas.org>
 <20051120103536.GB12997@granada.merseine.nu>
 <200511202139.01299.kernel@kolivas.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 20, 2005 at 09:39:00PM +1100, Con Kolivas wrote:
> On Sun, 20 Nov 2005 21:35, Muli Ben-Yehuda wrote:

> If it was instant it shouldn't matter. I'm aware of that in theory, but there 
> have certainly been reports of pthread_join taking quite a while happening in 
> a sort of lazy/sloppy way. I don't know why this is the case but I wondered 
> if it was showing up here. 

I see, I didn't realize pthread_join might not return immediately even
if the thread already finished (I would actually consider that a
bug...). Marcel, could you please check?

Cheers,
Muli
-- 
Muli Ben-Yehuda
http://www.mulix.org | http://mulix.livejournal.com/

