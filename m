Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314475AbSEHPfF>; Wed, 8 May 2002 11:35:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314477AbSEHPfE>; Wed, 8 May 2002 11:35:04 -0400
Received: from ua83d37hel.dial.kolumbus.fi ([62.248.234.83]:20299 "EHLO
	rankki.uworld.dyndns.org") by vger.kernel.org with ESMTP
	id <S314475AbSEHPfE>; Wed, 8 May 2002 11:35:04 -0400
Message-ID: <3CD94582.DE18AB99@kolumbus.fi>
Date: Wed, 08 May 2002 18:34:26 +0300
From: Jussi Laako <jussi.laako@kolumbus.fi>
X-Mailer: Mozilla 4.79 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Mike Kravetz <kravetz@us.ibm.com>
CC: Robert Love <rml@tech9.net>, mingo@elte.hu, linux-kernel@vger.kernel.org
Subject: Re: O(1) scheduler gives big boost to tbench 192
In-Reply-To: <20020507151356.A18701@w-mikek.des.beaverton.ibm.com> <E175DhD-0000HF-00@the-village.bc.nu> <20020507154322.F1537@w-mikek2.des.beaverton.ibm.com> <1020814775.2084.43.camel@bigsur> <20020507164857.G1537@w-mikek2.des.beaverton.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Kravetz wrote:
> 
> I'd really like to know if there are any real workloads that
> benefited from this feature, rather than just some benchmark.

Maybe this is the reason why O(1) scheduler has big latencies with
pthread_cond_*() functions which original scheduler doesn't have?
I think I tracked the problem down to try_to_wake_up(), but I was unable to
fix it.


	- Jussi Laako

-- 
PGP key fingerprint: 161D 6FED 6A92 39E2 EB5B  39DD A4DE 63EB C216 1E4B
Available at PGP keyservers

