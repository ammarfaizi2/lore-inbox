Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270880AbUJVI4l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270880AbUJVI4l (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 04:56:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270876AbUJVI4k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 04:56:40 -0400
Received: from pD9E39197.dip.t-dialin.net ([217.227.145.151]:774 "EHLO
	pro01.local.promotion-ie.de") by vger.kernel.org with ESMTP
	id S270881AbUJVIzn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 04:55:43 -0400
From: alex@local.promotion-ie.de
Subject: Re: [ALPHA 2.6.9] __ioremap gone in include/asm-alpha/io.h
To: alex@local.promotion-ie.de
Cc: Kernel-List <linux-kernel@vger.kernel.org>
In-Reply-To: <1098434690.30820.29.camel@pro30.local.promotion-ie.de>
References: <1098432320.30655.8.camel@pro30.local.promotion-ie.de>
	 <1098434690.30820.29.camel@pro30.local.promotion-ie.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1098435243.30655.32.camel@pro30.local.promotion-ie.de>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 22 Oct 2004 10:54:03 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Fr, den 22.10.2004 schrieb alex@local.promotion-ie.de um 10:44:
> Am Fr, den 22.10.2004 schrieb Alexander Rauth um 10:05:
> > In 2.6.9 __ioremap( ) is gone in include/asm-alpha/io.h resp. the
> > #define that linked alphas generic ioremap was deleted
> > 
>
> adding following line to include/asm-alpha/io.h fixed compile:
> 
> #define __ioremap(a,s) alpha_mv.mv_ioremap((unsigned long)(a),(s))
> 
fixed kernel did not boot at all. stuck after aboot
