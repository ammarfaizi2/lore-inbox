Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261688AbVGSUPJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261688AbVGSUPJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Jul 2005 16:15:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261687AbVGSUPI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Jul 2005 16:15:08 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:22212 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261688AbVGSUPG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Jul 2005 16:15:06 -0400
Date: Tue, 19 Jul 2005 22:15:04 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: 7eggert@gmx.de
cc: ivan@yosifov.net, linux-kernel@vger.kernel.org
Subject: Re: Noob question. Why is the for-pentium4 kernel built with 
 -march=i686 ?
In-Reply-To: <E1DuyS0-00013Z-VG@be1.lrz>
Message-ID: <Pine.LNX.4.61.0507192214100.16157@yvahk01.tjqt.qr>
References: <4s3M3-ph-15@gated-at.bofh.it> <4s4y2-Rt-17@gated-at.bofh.it>
 <4s5aD-1sw-3@gated-at.bofh.it> <E1DuyS0-00013Z-VG@be1.lrz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>AFAIK it's not possible to use SSE and MME in kernel mode, since these
>registers aren't preserved (it would be expensive).

Floating point is anyway a no-no in the kernel. 



Jan Engelhardt
-- 
| Alphagate Systems, http://alphagate.hopto.org/
