Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316199AbSINMsU>; Sat, 14 Sep 2002 08:48:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316342AbSINMsU>; Sat, 14 Sep 2002 08:48:20 -0400
Received: from c16598.thoms1.vic.optusnet.com.au ([210.49.243.217]:37032 "HELO
	pc.kolivas.net") by vger.kernel.org with SMTP id <S316199AbSINMsU>;
	Sat, 14 Sep 2002 08:48:20 -0400
Message-ID: <1032007992.3d8331387ea98@kolivas.net>
Date: Sat, 14 Sep 2002 22:53:12 +1000
From: Con Kolivas <conman@kolivas.net>
To: Paolo Ciarrocchi <ciarrocchi@linuxmail.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: System response benchmarks in performance patches
References: <20020914123948.26265.qmail@linuxmail.org>
In-Reply-To: <20020914123948.26265.qmail@linuxmail.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Paolo Ciarrocchi <ciarrocchi@linuxmail.org>:

> [...]
> >http://kernel.kolivas.net under the FAQ. A final >reminder note: it won't
> work on
> >2.5.x
> 
> Con, 
> I think that only the _memload_ test is not
> working with 2.5.*, am I wrong?

Correct. memload determines the amount of memory to allocate based on
/proc/meminfo which has changed in 2.5.x

Thanks for doing the 2.5.34 tests. They are promising results.

Con.

P.S. How does 2.4.19-ck7 compare ;-)
