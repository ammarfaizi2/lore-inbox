Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267613AbUHRXUk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267613AbUHRXUk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Aug 2004 19:20:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267614AbUHRXUk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Aug 2004 19:20:40 -0400
Received: from mailfe01.swip.net ([212.247.154.1]:45449 "EHLO
	mailfe01.swip.net") by vger.kernel.org with ESMTP id S267613AbUHRXUf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Aug 2004 19:20:35 -0400
X-T2-Posting-ID: dCnToGxhL58ot4EWY8b+QGwMembwLoz1X2yB7MdtIiA=
Date: Wed, 18 Aug 2004 16:14:15 -0700
From: Paul Jackson <pj@sgi.com>
To: Samuel Thibault <samuel.thibault@ens-lyon.org>
Cc: linux.kernel@vger.kernel.org
Subject: Re: warning: comparison is always false due to limited range of 
 data type
Message-Id: <20040818161415.1858c5f7.pj@sgi.com>
In-Reply-To: <20040818225304.GF22559@bouh.is-a-geek.org>
References: <2qIDQ-7ZR-13@gated-at.bofh.it>
	<2qK2T-oz-1@gated-at.bofh.it>
	<2qWQx-Hi-7@gated-at.bofh.it>
	<2r8oA-ks-1@gated-at.bofh.it>
	<20040818225304.GF22559@bouh.is-a-geek.org>
Organization: SGI
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Report: * -1.0 IN_REP_TO 'In-Reply-To' line found
	* -2.5 BAYES_00 BODY: Bayesian spam probability is 0 to 1%
	*      [score: 0.0000]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Samuel wrote:
> Here is another approach. This should never warning, and should get
> optimized away as needed.

Yours looks like it has a better chance of not being broken by some
future gcc enhancement that can see through the obfuscation in mine.

I didn't actually try it, but yours looks good to me.

Thanks.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
