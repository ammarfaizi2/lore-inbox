Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261637AbTHSVlO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 17:41:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261471AbTHSViu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 17:38:50 -0400
Received: from holomorphy.com ([66.224.33.161]:24705 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S261499AbTHSVip (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 17:38:45 -0400
Date: Tue, 19 Aug 2003 14:39:37 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Chuck Luciano <chuck@mrluciano.com>,
       Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: redhat 2.4.20 kernel 3.5G patch, bug report on my previous 2.4.18 kernel 3.5G patch
Message-ID: <20030819213937.GA4306@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Dave Hansen <haveblue@us.ibm.com>,
	Chuck Luciano <chuck@mrluciano.com>,
	Linux-Kernel <linux-kernel@vger.kernel.org>
References: <NFBBKNADOLMJPCENHEALCENAGLAA.chuck@mrluciano.com> <1061327818.25944.48.camel@nighthawk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1061327818.25944.48.camel@nighthawk>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 19, 2003 at 02:16:58PM -0700, Dave Hansen wrote:
> Actually, I would just do what we did in 2.5 and throw away *_pgd_fast()
> functions and just use a slab constructor and destructor to handle it
> for you.

Please be patient for the preconstruction that works with highpte; I
have code, but am holding back to keep the number of potentially
destabilizing changes simultaneously in the air down to a reasonable
number.


-- wli
