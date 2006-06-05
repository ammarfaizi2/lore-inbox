Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S932391AbWFECqu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932391AbWFECqu (ORCPT <rfc822;akpm@zip.com.au>);
	Sun, 4 Jun 2006 22:46:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932392AbWFECqu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jun 2006 22:46:50 -0400
Received: from rwcrmhc14.comcast.net ([216.148.227.154]:31228 "EHLO
	rwcrmhc14.comcast.net") by vger.kernel.org with ESMTP
	id S932391AbWFECqt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jun 2006 22:46:49 -0400
Message-ID: <44839B1B.6050607@namesys.com>
Date: Sun, 04 Jun 2006 19:46:51 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Barry K. Nathan" <barryn@pobox.com>
CC: Ingo Molnar <mingo@elte.hu>, Valdis.Kletnieks@vt.edu,
        Andrew Morton <akpm@osdl.org>, arjan@linux.intel.com,
        linux-kernel@vger.kernel.org, reiserfs-dev@namesys.com,
        Alexander Zarochentcev <zam@namesys.com>
Subject: Re: 2.6.17-rc5-mm3: bad unlock ordering (reiser4?)
References: <986ed62e0606040504n148bf744x77bd0669a5642dd0@mail.gmail.com>	 <20060604133326.f1b01cfc.akpm@osdl.org>	 <200606042056.k54KuoKQ005588@turing-police.cc.vt.edu>	 <20060604213432.GB5898@elte.hu> <986ed62e0606041503v701f8882la4cbead47ae3982f@mail.gmail.com>
In-Reply-To: <986ed62e0606041503v701f8882la4cbead47ae3982f@mail.gmail.com>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Barry K. Nathan wrote:

> On 6/4/06, Ingo Molnar <mingo@elte.hu> wrote:
>
>> nevertheless i'll turn that warning into a less scary message.
>
>
> This discussion seems to imply that I reported a false positive... is
> it *known* that I reported a false positive, or is it only a strong
> possibility?
>
> Assuming it's a false positive: Since this stops the tracer, it means
> that if an actual deadlock possibility is detected later [I'm assuming
> that detection of those doesn't get shut down by the bad-lock-ordering
> detection either], useful information could be missing from
> /proc/latency_trace, if I am not mistaken. Perhaps this could impede
> lockdep testing for people running reiser4 filesystems. I guess this
> is just a theoretical possibility at this point, but perhaps it's
> worth mentioning.

Monday Russian time Zam will be in, he is the locking guy for reiser4.
