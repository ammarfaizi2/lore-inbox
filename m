Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263626AbUHJJAQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263626AbUHJJAQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 05:00:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263204AbUHJI6m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 04:58:42 -0400
Received: from holomorphy.com ([207.189.100.168]:14823 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S263024AbUHJI4t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 04:56:49 -0400
Date: Tue, 10 Aug 2004 01:56:39 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Jesse Barnes <jbarnes@engr.sgi.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: 2.6.8-rc3-mm2
Message-ID: <20040810085639.GJ11200@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Ingo Molnar <mingo@elte.hu>, Jesse Barnes <jbarnes@engr.sgi.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	Nick Piggin <nickpiggin@yahoo.com.au>
References: <20040809112550.2ea19dbf.akpm@osdl.org> <200408091132.39752.jbarnes@engr.sgi.com> <200408091217.50786.jbarnes@engr.sgi.com> <20040809195323.GU11200@holomorphy.com> <20040809204357.GX11200@holomorphy.com> <20040809211042.GY11200@holomorphy.com> <20040809224546.GZ11200@holomorphy.com> <20040810063445.GE11200@holomorphy.com> <20040810080206.GF11200@holomorphy.com> <20040810083018.GA27270@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040810083018.GA27270@elte.hu>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* William Lee Irwin III <wli@holomorphy.com> wrote:
>> Okay, it's down to one printk() and other smaller changes now. The
>> mb() and __init removal are both unnecessary too.

On Tue, Aug 10, 2004 at 10:30:18AM +0200, Ingo Molnar wrote:
> so the same patch but without the printk change still crashes?
> how about applying only the printk change? (delay effect?)

Actually, what I just narrowed it down to was *only* the printk change
fixes it.


-- wli
