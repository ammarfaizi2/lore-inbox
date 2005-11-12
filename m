Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932383AbVKLOYP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932383AbVKLOYP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Nov 2005 09:24:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932384AbVKLOYP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Nov 2005 09:24:15 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:29909 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932383AbVKLOYO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Nov 2005 09:24:14 -0500
Date: Sat, 12 Nov 2005 15:24:28 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Sven-Thorsten Dietrich <sven@mvista.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.6.14-rt11 3/3] Fix ppc32 bootwrapper code for new zlib
Message-ID: <20051112142428.GC24163@elte.hu>
References: <20051111204312.11609.23222.sendpatchset@localhost.localdomain> <20051111204331.11609.46440.sendpatchset@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051111204331.11609.46440.sendpatchset@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Tom Rini <trini@kernel.crashing.org> wrote:

> Make the ppc32 bootwrapper code mirror what the ppc64 version does to 
> clean out locking, etc, from lib/zlib_inflate/
> 
> Signed-off-by: Tom Rini <trini@kernel.crashing.org>

why is this needed in -rt? Shouldnt this go upstream?

	Ingo
