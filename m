Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750897AbVKXEXq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750897AbVKXEXq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 23:23:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751334AbVKXEXq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 23:23:46 -0500
Received: from mx1.redhat.com ([66.187.233.31]:21416 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750897AbVKXEXp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 23:23:45 -0500
Date: Wed, 23 Nov 2005 23:21:50 -0500
From: Dave Jones <davej@redhat.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: "Randy.Dunlap" <rdunlap@xenotime.net>, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [-mm patch] init/main.c: dummy mark_rodata_ro() should be static
Message-ID: <20051124042150.GC30849@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Adrian Bunk <bunk@stusta.de>, "Randy.Dunlap" <rdunlap@xenotime.net>,
	Andrew Morton <akpm@osdl.org>,
	Arjan van de Ven <arjan@infradead.org>,
	linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
References: <20051123033550.00d6a6e8.akpm@osdl.org> <20051123223505.GF3963@stusta.de> <Pine.LNX.4.58.0511231443420.20189@shark.he.net> <20051123225440.GJ3963@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051123225440.GJ3963@stusta.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 23, 2005 at 11:54:40PM +0100, Adrian Bunk wrote:
 > On Wed, Nov 23, 2005 at 02:46:51PM -0800, Randy.Dunlap wrote:
 > > On Wed, 23 Nov 2005, Adrian Bunk wrote:
 > > 
 > > > Every inline dummy function should be static.
 > > 
 > > Please explain why it matters in this case.
 > 
 > We don't need an additional global copy of the function.

it's an empty body, surely the compiler will compile it away ?

		Dave

