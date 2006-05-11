Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750885AbWEKKeV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750885AbWEKKeV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 May 2006 06:34:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751536AbWEKKeV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 May 2006 06:34:21 -0400
Received: from dze141s31.ae.poznan.pl.220.254.150.in-addr.arpa ([150.254.220.184]:17333
	"EHLO dns.toxicfilms.tv") by vger.kernel.org with ESMTP
	id S1750885AbWEKKeU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 May 2006 06:34:20 -0400
X-Spam-Report: SA TESTS
 -1.7 ALL_TRUSTED            Passed through trusted hosts only via SMTP
 -2.3 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
                             [score: 0.0000]
  0.6 AWL                    AWL: From: address is in the auto white-list
X-QSS-TOXIC-Mail-From: solt2@dns.toxicfilms.tv via dns
X-QSS-TOXIC: 1.25st (Clear:RC:1(85.221.144.160):SA:0(-3.4/3.0):. Processed in 0.742452 secs Process 22345)
Date: Thu, 11 May 2006 12:34:19 +0200
From: Maciej Soltysiak <solt2@dns.toxicfilms.tv>
Reply-To: Maciej Soltysiak <solt2@dns.toxicfilms.tv>
X-Priority: 3 (Normal)
Message-ID: <296295514.20060511123419@dns.toxicfilms.tv>
To: Chris Wright <chrisw@sous-sol.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.16.16
In-Reply-To: <20060511022547.GE25010@moss.sous-sol.org>
References: <20060511022547.GE25010@moss.sous-sol.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Chris,

Thursday, May 11, 2006, 4:25:47 AM, you wrote:
> Trond Myklebust:
>       fs/locks.c: Fix lease_init (CVE-2006-1860)
I want to say that I like the quick stable cycle. People like to see
fixes. Big thanks!

However...
I must say that usually I know if I need the the update,
eg. I do not care for SCTP that much so I could skip that update.

But this one looks important, something that every kernel build
has in its code path, however I am unable to say if I need it badly
or maybe not.

The url: http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2006-1860
says nothing about it.

Could we have a word or two under each patchlet that would qualify them
somehow?
Like:
"Important, not required for all, apply if using SCTP"
"Important, required for all, may *do bad things*, apply ASAP"
"Critical, required for all, surely will *do bad things*, apply ASAP"

Not only distro kernel developers/maintainers use these, so I think
it would be nice.

Best Regards,
Maciej


