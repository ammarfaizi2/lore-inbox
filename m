Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750777AbWH1Q1t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750777AbWH1Q1t (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 12:27:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751149AbWH1Q1t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 12:27:49 -0400
Received: from mx1.suse.de ([195.135.220.2]:5292 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750777AbWH1Q1s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 12:27:48 -0400
To: Arjan van de Ven <arjan@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, mingo@elte.hu,
       jesse.barnes@intel.com, dwalker@mvista.com,
       andi@rhlx01.fht-esslingen.de
Subject: Re: [PATCH] maximum latency tracking infrastructure (version 3)
References: <1156780080.3034.207.camel@laptopd505.fenrus.org>
	<20060828161145.GA25161@rhlx01.fht-esslingen.de>
	<44F3178F.8010508@linux.intel.com>
From: Andi Kleen <ak@suse.de>
Date: 28 Aug 2006 18:27:46 +0200
In-Reply-To: <44F3178F.8010508@linux.intel.com>
Message-ID: <p73bqq47rlp.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven <arjan@linux.intel.com> writes:
> 
> I could have sworn there was an idle call notifier already\
> 
> ah there is on x86-64 but it is architecture specific...

The original implementation was on s390. But they're not really
designed for doing anything slow, so I wouldn't recommend using
them in drivers unless it's very fast.

-Andi
