Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319342AbSH2Vjy>; Thu, 29 Aug 2002 17:39:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319344AbSH2Vjx>; Thu, 29 Aug 2002 17:39:53 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:22282
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S319342AbSH2Vjx>; Thu, 29 Aug 2002 17:39:53 -0400
Subject: Re: [PATCH] compile-time configurable NR_CPUS
From: Robert Love <rml@tech9.net>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020829214230.GH888@holomorphy.com>
References: <1030635200.939.2561.camel@phantasy> 
	<20020829214230.GH888@holomorphy.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 29 Aug 2002 17:44:20 -0400
Message-Id: <1030657461.11553.2693.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-08-29 at 17:42, William Lee Irwin III wrote:

> Could you make CONFIG_NR_CPUS only for non-NUMA-Q systems and hardwire
> it to 32 for NUMA-Q, as the bugs in io_apic.c don't have fixes yet and
> NUMA-Q's have enough IO-APIC's to trigger the bugs.

Ugh.

Linus has not shown any interest in merging, so it is a non-issue at the
moment...

	Robert Love

