Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265136AbTLRNdj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Dec 2003 08:33:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265143AbTLRNdj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Dec 2003 08:33:39 -0500
Received: from holomorphy.com ([199.26.172.102]:63123 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S265136AbTLRNdi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Dec 2003 08:33:38 -0500
Date: Thu, 18 Dec 2003 05:33:04 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Bill Davidsen <davidsen@tmr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Response testing on 2.6.0-test11 variants
Message-ID: <20031218133304.GC22443@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Bill Davidsen <davidsen@tmr.com>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0312171549550.3466-300000@oddball.prodigy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0312171549550.3466-300000@oddball.prodigy.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 17, 2003 at 03:51:30PM -0500, Bill Davidsen wrote:
>                     _____________ delay ms. ____________     ___ Ratio ___
>         Test        low       high    median     average      raw     S.D.
> v      noload    246.138    295.824    250.364    261.131    1.000    1.000
> w      noload    241.308    507.529    251.228    314.148    1.000    1.000
> v  smallwrite    283.588   7725.815   2287.066   3286.297   12.585    5.110
> w  smallwrite    819.019   4922.349   1273.123   2052.233    6.533    5.389
> v  largewrite   1026.081   5734.609   3395.009   3436.063   13.158   13.721
> w  largewrite   1781.760   9437.622   3838.493   4939.853   15.725   13.092
> v     cpuload    271.338    589.871    286.339    342.194    1.310    1.110
> w     cpuload    269.542    562.006    277.177    352.739    1.123    1.213
> v   spawnload    271.747    388.543    287.548    304.779    1.167    1.124
> w   spawnload    265.993    462.221    274.887    309.579    0.985    1.096
> v    8ctx-mem   4082.105  15076.516  11357.832  10469.028   40.091   51.557
> w    8ctx-mem   7499.271  24126.753  16028.938  15420.571   49.087   68.186
> v    2ctx-mem  10019.499  15834.343  12848.258  12858.138   49.240   50.796
> w    2ctx-mem  12701.278  39539.505  26427.740  25699.607   81.807  102.920

hrandoz has identified some recent degradations in -wli vs. prior -wli
versions; I'm going to try to track down the source of those in the near
future.

-- wli
