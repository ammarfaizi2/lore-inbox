Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751207AbWHBJ3M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751207AbWHBJ3M (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 05:29:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751278AbWHBJ3M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 05:29:12 -0400
Received: from mailer.gwdg.de ([134.76.10.26]:36041 "EHLO mailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1751207AbWHBJ3L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 05:29:11 -0400
Date: Wed, 2 Aug 2006 11:28:51 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Sven Anders <s.anders@digitec.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: What happens if the klogd dies
In-Reply-To: <200608020915.25369.s.anders@digitec.de>
Message-ID: <Pine.LNX.4.61.0608021125150.24592@yvahk01.tjqt.qr>
References: <200608020915.25369.s.anders@digitec.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Hi,
>I wander what happens it the klog-daemon do not work.

Nothing. Messages just do not get logged.

>Is it posible that, after a amount of time the kernel crash, bescause of that?

Unlikely, because it would require a kernel crash in a place that would 
very likely bring the whole system down (procfs, sockfs).


