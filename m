Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313773AbSHFPR0>; Tue, 6 Aug 2002 11:17:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314514AbSHFPR0>; Tue, 6 Aug 2002 11:17:26 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:23826 "HELO
	garrincha.netbank.com.br") by vger.kernel.org with SMTP
	id <S313773AbSHFPRZ>; Tue, 6 Aug 2002 11:17:25 -0400
Date: Tue, 6 Aug 2002 11:20:04 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Steven Cole <elenstev@mesatop.com>
cc: Andrew Morton <akpm@zip.com.au>, Bill Davidsen <davidsen@tmr.com>,
       Marcelo Tosatti <marcelo@conectiva.com.br>, Jens Axboe <axboe@suse.de>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.4.19-rc5
In-Reply-To: <1028642837.2802.59.camel@spc9.esa.lanl.gov>
Message-ID: <Pine.LNX.4.44L.0208061116460.23404-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6 Aug 2002, Steven Cole wrote:

> That last one looks like the biggest cheat.  Rather than optimizing for
> dbench, is there a set of pessimizing numbers which would optimally turn
> dbench into a semi-useful tool for measuring meaningful IO performance?
> Or is dbench really only useful for stress testing?

Yes, dbench is only useful as a stress testing tool.

A minor varation in kernel behaviour can change dbench
throughput by an order of magnitude and I'm not talking
about any specific kernel component here ... ANY kernel
component could trigger it.

While it is easy to measure dbench throughput, it is
nearly impossible to:

1) analyse why dbench throughput changed from kernel to kernel

2) predict the relation (if any) these changes in dbench
   throughput have with changes in performance of real
   applications, if any

3) identify which kernel subsystem was responsible for the
   change in dbench performance

regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

