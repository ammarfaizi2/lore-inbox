Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265169AbTLZL4z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Dec 2003 06:56:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265171AbTLZL4z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Dec 2003 06:56:55 -0500
Received: from holomorphy.com ([199.26.172.102]:18860 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S265169AbTLZL4y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Dec 2003 06:56:54 -0500
Date: Fri, 26 Dec 2003 03:56:47 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Nick Craig-Wood <ncw1@axis.demon.co.uk>
Cc: linux-kernel@vger.kernel.org, Rohit Seth <rohit.seth@intel.com>
Subject: Re: 2.6.0 Huge pages not working as expected
Message-ID: <20031226115647.GH27687@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Nick Craig-Wood <ncw1@axis.demon.co.uk>,
	linux-kernel@vger.kernel.org, Rohit Seth <rohit.seth@intel.com>
References: <20031226105433.GA25970@axis.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031226105433.GA25970@axis.demon.co.uk>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 26, 2003 at 10:54:33AM +0000, Nick Craig-Wood wrote:
> I wrote a little test program to show the benefits of huge pages by
> reducing TLB thrashing - it fills up 16 MB with sequential numbers
> then adds them with different strides - very much the sort of thing
> FFTs do.  However huge pages show a performance decrease not increase
> for large strides!  For smaller ones there is a small speedup.
> I've been testing on
> processor       : 0
> vendor_id       : GenuineIntel
> cpu family      : 6
> model           : 8
> model name      : Pentium III (Coppermine)

P-III has something like 2 TLB entries usable for large pages.
I recommend trying this again on a P-IV.


-- wli
