Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262117AbVAKUio@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262117AbVAKUio (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 15:38:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262156AbVAKUif
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 15:38:35 -0500
Received: from holomorphy.com ([207.189.100.168]:1671 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S262117AbVAKUgc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 15:36:32 -0500
Date: Tue, 11 Jan 2005 12:36:29 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] silence numerous size_t warnings in drivers/acpi/processor_idle.c
Message-ID: <20050111203629.GB14443@holomorphy.com>
References: <200501111916.j0BJGq1F010042@hera.kernel.org> <41E436AC.1050004@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41E436AC.1050004@osdl.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2334, 2005/01/11 09:21:40-08:00, wli@holomorphy.com
>>	[PATCH] silence numerous size_t warnings in 
>>	drivers/acpi/processor_idle.c
>>	Multiple format -related warnings arise from size_t issues.  This 
>>	patch
>>	peppers the seq_printf()'s with 'z' qualifiers and casts to silence 
>>	them all.

On Tue, Jan 11, 2005 at 12:27:24PM -0800, Randy.Dunlap wrote:
> Does this mean that ptrdiff_t type looks same as a size_t
> to printk() & seq_printf() ?

As far as I know this is the case. I have no specific opinion on this
being a better way to do it than something else.


-- wli
