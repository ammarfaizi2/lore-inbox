Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275927AbSIURjq>; Sat, 21 Sep 2002 13:39:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275928AbSIURjq>; Sat, 21 Sep 2002 13:39:46 -0400
Received: from holomorphy.com ([66.224.33.161]:30093 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S275927AbSIURjp>;
	Sat, 21 Sep 2002 13:39:45 -0400
Date: Sat, 21 Sep 2002 10:38:15 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Erich Focht <efocht@ess.nec.de>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       LSE <lse-tech@lists.sourceforge.net>, Ingo Molnar <mingo@elte.hu>,
       Michael Hohnbaum <hohnbaum@us.ibm.com>
Subject: Re: [Lse-tech] [PATCH 1/2] node affine NUMA scheduler
Message-ID: <20020921173815.GE28202@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Erich Focht <efocht@ess.nec.de>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	LSE <lse-tech@lists.sourceforge.net>, Ingo Molnar <mingo@elte.hu>,
	Michael Hohnbaum <hohnbaum@us.ibm.com>
References: <598631797.1032601564@[10.10.2.3]> <600156739.1032603089@[10.10.2.3]> <200209211932.59871.efocht@ess.nec.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <200209211932.59871.efocht@ess.nec.de>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 21, 2002 at 07:32:59PM +0200, Erich Focht wrote:
> Might also be that the __node_distance matrix which you might use
> by default is not optimal for NUMAQ. It is fine for our remote/local
> latency ratio of 1.6. Yours is maybe an order of magnitude larger?
> Try replacing: 15 -> 50, guess you don't go beyond 4 nodes now...

I'm running with 8 over the weekend, and by and large we go to 16,
though we rarely put all our eggs in one basket.

I'll take it for a spin.


Cheers,
Bill
