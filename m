Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264808AbUHSJ05@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264808AbUHSJ05 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 05:26:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264668AbUHSJ04
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 05:26:56 -0400
Received: from holomorphy.com ([207.189.100.168]:48574 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S264685AbUHSJ02 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 05:26:28 -0400
Date: Thu, 19 Aug 2004 02:26:15 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Lee Revell <rlrevell@joe-job.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Thomas Charbonnel <thomas@undata.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Subject: Re: [patch] voluntary-preempt-2.6.8.1-P4
Message-ID: <20040819092615.GI11200@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Ingo Molnar <mingo@elte.hu>, Lee Revell <rlrevell@joe-job.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Thomas Charbonnel <thomas@undata.org>,
	Florian Schmidt <mista.tapas@gmx.net>,
	Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
References: <1092628493.810.3.camel@krustophenia.net> <20040816040515.GA13665@elte.hu> <1092654819.5057.18.camel@localhost> <20040816113131.GA30527@elte.hu> <20040816120933.GA4211@elte.hu> <1092716644.876.1.camel@krustophenia.net> <20040817080512.GA1649@elte.hu> <20040819073247.GA1798@elte.hu> <1092902417.8432.108.camel@krustophenia.net> <20040819084001.GA4098@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040819084001.GA4098@elte.hu>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Lee Revell <rlrevell@joe-job.com> wrote:
>> Any comments on the unmap_vmas issue?

On Thu, Aug 19, 2004 at 10:40:01AM +0200, Ingo Molnar wrote:
> wli indicated he's working on the pagetable zapping critical section
> issue - wli?

What I have is meant to remove clear_page_tables() by incrementally
pruning at munmap() -time. As far as unmap_vmas() goes, it's not
directly pertinent. It rather affects (and is meant to remove)
clear_page_tables().


-- wli
