Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136511AbREDVOA>; Fri, 4 May 2001 17:14:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136513AbREDVNw>; Fri, 4 May 2001 17:13:52 -0400
Received: from dsl081-246-098.sfo1.dsl.speakeasy.net ([64.81.246.98]:26632
	"EHLO are.twiddle.net") by vger.kernel.org with ESMTP
	id <S136511AbREDVNX>; Fri, 4 May 2001 17:13:23 -0400
Date: Fri, 4 May 2001 14:13:18 -0700
From: Richard Henderson <rth@twiddle.net>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] 2.4.4 alpha semaphores optimization
Message-ID: <20010504141318.B11122@twiddle.net>
Mail-Followup-To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20010503194747.A552@jurassic.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010503194747.A552@jurassic.park.msu.ru>; from ink@jurassic.park.msu.ru on Thu, May 03, 2001 at 07:47:47PM +0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 03, 2001 at 07:47:47PM +0400, Ivan Kokshaysky wrote:
> Initially I tried to use __builtin_expect in the rwsem.h, but found
> that it doesn't help at all in the small inline functions - it works
> as expected only in a reasonably large block of code.

Eh?  Would you give me an example that isn't working properly?


r~
