Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264918AbTFCDeZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 23:34:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264919AbTFCDeZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 23:34:25 -0400
Received: from modemcable204.207-203-24.mtl.mc.videotron.ca ([24.203.207.204]:20610
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id S264918AbTFCDeY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 23:34:24 -0400
Date: Mon, 2 Jun 2003 23:36:13 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Con Kolivas <kernel@kolivas.org>
cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [BENCHMARK] 100Hz v 1000Hz with contest
In-Reply-To: <200306031322.01389.kernel@kolivas.org>
Message-ID: <Pine.LNX.4.50.0306022333250.14455-100000@montezuma.mastecende.com>
References: <200306031322.01389.kernel@kolivas.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Jun 2003, Con Kolivas wrote:

> I've attempted to answer the question does 1000Hz hurt responsiveness in 2.5
> as much as I've found in 2.4; since subjectively the difference wasn't there
> in 2.5. Using the same config with preempt enabled here are results from
> 2.5.70-mm3 set at default 1000Hz and at 100Hz (mm31):

Thanks for carrying out these =)

> ctar_load:
> Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
> 2.5.70-mm3          3   114     70.2    1.0     5.3     1.44
> 2.5.70-mm31         3   105     73.3    0.7     3.8     1.36

> dbench_load:
> Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
> 2.5.70-mm3          4   313     24.3    5.0     56.9    3.96
> 2.5.70-mm31         4   297     24.9    4.5     52.5    3.86
>
> At first glance everything looks faster at 100Hz. However it is well known
> that it will take slightly longer even with no load at 1000Hz. Taking that
> into consideration and looking more at the final ratios than the absolute
> numbers it is apparent that the difference is statistically insignificant,
> except on ctar_load.

What about dbench_load?
 
> Previously I had benchmark results on 1000Hz which showed preempt improved the
> results in a few of the loads. For my next experiment I will compare 100Hz
> with preempt to 100Hz without.

Cheers,
	Zwane
-- 
function.linuxpower.ca
