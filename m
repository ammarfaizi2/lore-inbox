Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264057AbUDFWeU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 18:34:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264054AbUDFWeU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 18:34:20 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:17901 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S264046AbUDFWeS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 18:34:18 -0400
Date: Tue, 6 Apr 2004 15:34:16 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Andrew Morton <akpm@osdl.org>, p_gortmaker@yahoo.com,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Re: [PATCH] don't offer GEN_RTC on ia64
Message-ID: <20040406223416.GH31152@smtp.west.cox.net>
References: <200404061622.49260.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200404061622.49260.bjorn.helgaas@hp.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 06, 2004 at 04:22:49PM -0600, Bjorn Helgaas wrote:

> gen_rtc.c doesn't work on ia64 (we don't have asm/rtc.h, for starters),
> so don't offer it there.

Why not provide asm/rtc.h and kill off drivers/char/efirtc.c instead? :)

-- 
Tom Rini
http://gate.crashing.org/~trini/
