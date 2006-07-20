Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964893AbWGTIK3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964893AbWGTIK3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jul 2006 04:10:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964895AbWGTIK3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jul 2006 04:10:29 -0400
Received: from mailer.gwdg.de ([134.76.10.26]:17864 "EHLO mailer.gwdg.de")
	by vger.kernel.org with ESMTP id S964893AbWGTIK2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jul 2006 04:10:28 -0400
Date: Thu, 20 Jul 2006 10:09:40 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Alexey Dobriyan <adobriyan@gmail.com>
cc: ricknu-0@student.ltu.se, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] A generic boolean
In-Reply-To: <20060719212049.GA6828@martell.zuzino.mipt.ru>
Message-ID: <Pine.LNX.4.61.0607201008140.19497@yvahk01.tjqt.qr>
References: <1153341500.44be983ca1407@portal.student.luth.se>
 <20060719212049.GA6828@martell.zuzino.mipt.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>  -Why we wouldn't want it
>  -C++ and Java fans will treat bool as a green light to the following
>
>	if (!(flags == true))
>  and
>	if (!(flags == false))
>
You can already do that with C. (given a #define true and #define false).
Just add something to CodingStyle like [warning: generalized] "we don't 
accept stupid bool logic code".


Jan Engelhardt
-- 
