Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261886AbVEKCzT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261886AbVEKCzT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 22:55:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261888AbVEKCzT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 22:55:19 -0400
Received: from mail15.syd.optusnet.com.au ([211.29.132.196]:7896 "EHLO
	mail15.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261886AbVEKCyi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 22:54:38 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Carlos Carvalho <carlos@fisica.ufpr.br>
Subject: Re: [ck] Re: [PATCH] implement nice support across physical cpus on SMP
Date: Wed, 11 May 2005 12:56:15 +1000
User-Agent: KMail/1.8
Cc: ck@vds.kolivas.org, Ingo Molnar <mingo@elte.hu>,
       Markus =?iso-8859-1?q?T=F6rnqvist?= <mjt@nysv.org>,
       linux-kernel@vger.kernel.org, AndrewMorton <akpm@osdl.org>
References: <20050509112446.GZ1399@nysv.org> <200505092147.06384.kernel@kolivas.org> <17023.63512.319555.552924@fisica.ufpr.br>
In-Reply-To: <17023.63512.319555.552924@fisica.ufpr.br>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505111256.15498.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 May 2005 09:54 am, Carlos Carvalho wrote:
> Con Kolivas (kernel@kolivas.org) wrote on 9 May 2005 21:47:
>  >Perhaps if I make the prio_bias multiplied instead of added to the cpu
>  > load it will be less affected by SCHED_LOAD_SCALE. The attached patch
>  > was confirmed during testing to also provide smp distribution according
>  > to nice on 4x.
>
> It seems to work. I've tested it for a few hours on the same machine
> and the 2 nice 0 processes take the bulk of the cpu time, while that
> cpu bound program running at nice 19 takes only about 7%.
>
> Maybe it's a bit early to say it's fine, but it does semm much better
> than before, so I think it should go into the tree.
>
> Thanks a lot!

My pleasure. Thanks for testing.

I'll roll up these patches for rc4 and make smp nice balancing a config option 
for ultimate flexibility.

Cheers,
Con
