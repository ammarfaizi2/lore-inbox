Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265237AbTLZUQI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Dec 2003 15:16:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265239AbTLZUQI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Dec 2003 15:16:08 -0500
Received: from holomorphy.com ([199.26.172.102]:26541 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S265237AbTLZUQF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Dec 2003 15:16:05 -0500
Date: Fri, 26 Dec 2003 12:15:57 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Nick Craig-Wood <ncw1@axis.demon.co.uk>
Cc: linux-kernel@vger.kernel.org, Rohit Seth <rohit.seth@intel.com>
Subject: Re: 2.6.0 Huge pages not working as expected
Message-ID: <20031226201557.GI27687@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Nick Craig-Wood <ncw1@axis.demon.co.uk>,
	linux-kernel@vger.kernel.org, Rohit Seth <rohit.seth@intel.com>
References: <20031226105433.GA25970@axis.demon.co.uk> <20031226115647.GH27687@holomorphy.com> <20031226201011.GA32316@axis.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031226201011.GA32316@axis.demon.co.uk>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 26, 2003 at 08:10:11PM +0000, Nick Craig-Wood wrote:
> Any other ideas?
> (Interesting note - the 700 MHz P3 laptop is nearly twice as fast as
> the 1.7 GHx P4 dekstop (261ms vs 489ms) at the span 4096 case, but the
> P4 beats the P3 by a factor of 23 for the stride 1 (3ms vs 71 ms)!)

Well, at this point I'd say point oprofile at it to try to figure
out what the overhead(s) are causing the degradation.


-- wli
