Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422805AbWKHUQG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422805AbWKHUQG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 15:16:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422810AbWKHUQG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 15:16:06 -0500
Received: from mx1.redhat.com ([66.187.233.31]:10894 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1422805AbWKHUQD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 15:16:03 -0500
Date: Wed, 8 Nov 2006 15:15:39 -0500
From: Dave Jones <davej@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Reuben Farrelly <reuben-linuxkernel@reub.net>,
       linux-kernel@vger.kernel.org, Roman Zippel <zippel@linux-m68k.org>
Subject: Re: 2.6.19-rc5-mm1
Message-ID: <20061108201539.GB32721@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Andrew Morton <akpm@osdl.org>,
	Reuben Farrelly <reuben-linuxkernel@reub.net>,
	linux-kernel@vger.kernel.org, Roman Zippel <zippel@linux-m68k.org>
References: <20061108015452.a2bb40d2.akpm@osdl.org> <4551BB5E.6090602@reub.net> <20061108120547.78048229.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061108120547.78048229.akpm@osdl.org>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 08, 2006 at 12:05:47PM -0800, Andrew Morton wrote:

 > The problem is that you have 
 > 
 > > CONFIG_CPU_FREQ_TABLE=m
 > > CONFIG_X86_ACPI_CPUFREQ=y
 > 
 > but acpi-cpufreq needs the stuff in freq_table.c.
 > 
 > This happens again and again and again and again.  I wish people would just
 > stop using `select'.  It.  Doesn't.  Work.
 > 
 > Either we fix select or we stop using the damn thing.

So, why doesn't select set the symbol it's selecting to the
same value as the symbol being configured ?
That would solve the issue no?

		Dave

-- 
http://www.codemonkey.org.uk
