Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265380AbSKOAdd>; Thu, 14 Nov 2002 19:33:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265402AbSKOAdc>; Thu, 14 Nov 2002 19:33:32 -0500
Received: from zeus.kernel.org ([204.152.189.113]:27823 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S265380AbSKOAda>;
	Thu, 14 Nov 2002 19:33:30 -0500
Date: Thu, 14 Nov 2002 13:02:20 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Benjamin LaHaise <bcrl@redhat.com>
Cc: Andrew Morton <akpm@digeo.com>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] remove hugetlb syscalls
Message-ID: <20021114210220.GM23425@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Benjamin LaHaise <bcrl@redhat.com>, Andrew Morton <akpm@digeo.com>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20021113184555.B10889@redhat.com> <20021114203035.GF22031@holomorphy.com> <20021114154809.D20258@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021114154809.D20258@redhat.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 14, 2002 at 12:30:35PM -0800, William Lee Irwin III wrote:
>> The main reason I haven't considered doing this is because they already
>> got in and there appears to be a user (Oracle/IA64).

On Thu, Nov 14, 2002 at 03:48:09PM -0500, Benjamin LaHaise wrote:
> Not in shipping code.  Certainly no vendor kernels that I am aware of 
> have shipped these syscalls yet either, as nearly all of the developers 
> find them revolting.  Not to mention that the code cleanups and bugfixes 
> are still ongoing.

This is a bit out of my hands; the support decision came from elsewhere.
I have to service my users first, and after that, I don't generally want
to stand in the way of others. In general it's good to have minimalistic
interfaces, but I'm not a party to the concerns regarding the syscalls.
My direct involvement there has been either of a kernel janitor nature,
helping to adapt it to Linux kernel idioms, or reusing code for hugetlbfs.

I guess the only real statement left to make is that hugetlbfs (or my
participation/implementation of it) was not originally intended to
compete with the syscalls, though there's a lot of obvious overlap
(which I tried to exploit by means of code reuse).

Bill
