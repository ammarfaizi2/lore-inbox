Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316214AbSFDEXH>; Tue, 4 Jun 2002 00:23:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316217AbSFDEXG>; Tue, 4 Jun 2002 00:23:06 -0400
Received: from holomorphy.com ([66.224.33.161]:27011 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S316214AbSFDEXF>;
	Tue, 4 Jun 2002 00:23:05 -0400
Date: Mon, 3 Jun 2002 21:23:00 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Lightweight patch manager <patch@luckynet.dynu.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Subject: Re: linux-2.5.20-ct1
Message-ID: <20020604042300.GA8263@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Lightweight patch manager <patch@luckynet.dynu.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Daniel Phillips <phillips@bonn-fries.net>,
	Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
In-Reply-To: <Pine.LNX.4.44.0206032154470.17873-100000@hawkeye.luckynet.adm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 03, 2002 at 09:58:32PM -0600, Lightweight patch manager wrote:
> <wli@holomorphy.com>:
>   o remove mixture of non-atomic operations with page->flags which requires atomic operations to access
>   o repetitive reinitialization of active_list and inactive_list in free_area_init_core()
>   o make balance_classzone() use list.h
>   o complete comment regarding inner workings of buddy system
>   o duplicate declaration of rq in sched_init()
>   o Re: forget_pte()
>   o remove antiquated comment from page_alloc.c
>   o convert page_alloc.c bugchecks to BUG_ON()
>   o remove MARK_USED() macros
>   o remove memlist_* macros from page_alloc.c
>   o correct inaccurate comment regarding zone_table's usage

There were discussions about a number of these patches resulting in
changes, would you mind letting me know what versions of these things
you're pushing upstream and let me hand you updates?


Thanks,
Bill
