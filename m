Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266525AbUHBNob@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266525AbUHBNob (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 09:44:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266521AbUHBNob
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 09:44:31 -0400
Received: from holomorphy.com ([207.189.100.168]:34476 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S266525AbUHBNnU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 09:43:20 -0400
Date: Mon, 2 Aug 2004 06:42:57 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Peter Williams <pwil3058@bigpond.net.au>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Michal Kaczmarski <fallow@op.pl>, Shane Shrybman <shrybman@aei.ca>
Subject: Re: [PATCH] V-3.0 Single Priority Array O(1) CPU Scheduler Evaluation
Message-ID: <20040802134257.GE2334@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Peter Williams <pwil3058@bigpond.net.au>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Michal Kaczmarski <fallow@op.pl>, Shane Shrybman <shrybman@aei.ca>
References: <410DDFD2.5090400@bigpond.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <410DDFD2.5090400@bigpond.net.au>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 02, 2004 at 04:31:46PM +1000, Peter Williams wrote:
> 3. Priority based O(1) scheduler with active/expired arrays replaced by 
> a single array and an O(1) promotion mechanism plus scheduling 
> statistics with new interactive bonus mechanism and throughput bonus 
> mechanism:

Hmm. Given do_promotions() I'd expect fenceposts, not iteration over
the priority levels of the runqueue.


-- wli
