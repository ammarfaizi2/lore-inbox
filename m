Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262057AbTI0R0u (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Sep 2003 13:26:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262123AbTI0R0u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Sep 2003 13:26:50 -0400
Received: from mail1.bluewin.ch ([195.186.1.74]:12747 "EHLO mail1.bluewin.ch")
	by vger.kernel.org with ESMTP id S262057AbTI0R0s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Sep 2003 13:26:48 -0400
Date: Sat, 27 Sep 2003 19:26:39 +0200
From: Roger Luethi <rl@hellgate.ch>
To: Jason Lewis <jason@dickson.st>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG 2.6.90-test5] kernel shits itself with 48mb ram under moderate load
Message-ID: <20030927172639.GA19176@k3.hellgate.ch>
Mail-Followup-To: Jason Lewis <jason@dickson.st>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.53.0309280116450.336@car.swiftel.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0309280116450.336@car.swiftel.com.au>
X-Operating-System: Linux 2.6.0-test5 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 28 Sep 2003 01:26:34 +1000, Jason Lewis wrote:
> I seem to be experiencing some problems with it. boot and load X ok, but
> as soon as I try and do anything interesting in X, like run xchat, or
> apt-get update, the system grings to a halt. the load goes through the
> roof, and the hdd starts grinding away madly.
> 
> But I can run my system quite succesfully under 2.4
> 
> [...]
>
> Script started on Sun 28 Sep 2003 00:56:41 EST
> procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
>  r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
> [...]
>  1  8      0   3360    836   6024    0    0 16404    16 3666  2158  1 13  0 86
>  1 11      0   3504    828   5888    0    0 14956     4 6185  3344  0 11  0 89
>  3  9      0   3392    816   6016    0    0  6864     0 3903  2088  0 11  0 89
>  2 13      0   3464    820   5880    0    0 11148     0 3105  1960  0 12  0 87
>  0 12      0   3424    816   6008    0    0 19712     0 5519  3184  0 12  0 87

          ^^^^
Looks like you don't have swap enabled. Are successful 2.4 runs with or
without swap?

Roger
