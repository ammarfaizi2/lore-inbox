Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131958AbRDMVym>; Fri, 13 Apr 2001 17:54:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131973AbRDMVyX>; Fri, 13 Apr 2001 17:54:23 -0400
Received: from mailgw.prontomail.com ([216.163.180.10]:31680 "EHLO
	c0mailgw04.prontomail.com") by vger.kernel.org with ESMTP
	id <S131958AbRDMVyT>; Fri, 13 Apr 2001 17:54:19 -0400
Message-ID: <3AD77540.42BF138E@mvista.com>
Date: Fri, 13 Apr 2001 14:53:04 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.72 [en] (X11; I; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Horst von Brand <vonbrand@sleipnir.valparaiso.cl>
CC: Ben Greear <greearb@candelatech.com>, linux-kernel@vger.kernel.org,
        high-res-timers-discourse@lists.sourceforge.net
Subject: Re: No 100 HZ timer!
In-Reply-To: <200104131205.f3DC5KV11393@sleipnir.valparaiso.cl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Horst von Brand wrote:
> 
> Ben Greear <greearb@candelatech.com> said:
> 
> [...]
> 
> > Wouldn't a heap be a good data structure for a list of timers?  Insertion
> > is log(n) and finding the one with the least time is O(1), ie pop off the
> > front....  It can be implemented in an array which should help cache
> > coherency and all those other things they talked about in school :)
> 
> Insertion and deleting the first are both O(log N). Plus the array is fixed
> size (bad idea) and the jumping around in the array thrashes the caches.
> --
And your solution is?

George
