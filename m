Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946434AbWJSUPM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946434AbWJSUPM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 16:15:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946435AbWJSUPM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 16:15:12 -0400
Received: from emailer.gwdg.de ([134.76.10.24]:54224 "EHLO emailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1946434AbWJSUPK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 16:15:10 -0400
Date: Thu, 19 Oct 2006 22:14:43 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Avi Kivity <avi@qumranet.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/7] KVM: userspace interface
In-Reply-To: <453781F9.3050703@qumranet.com>
Message-ID: <Pine.LNX.4.61.0610192212590.8142@yvahk01.tjqt.qr>
References: <4537818D.4060204@qumranet.com> <453781F9.3050703@qumranet.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



>+#ifndef __user
>+#define __user
>+#endif

SHRUG. You should include <linux/compiler.h> instead of doing that. (And 
on top, it may happen that compiler.h is automatically slurped in like 
config.h, someone else could answer that)


	-`J'
-- 
