Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280731AbRKBQ63>; Fri, 2 Nov 2001 11:58:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280732AbRKBQ6S>; Fri, 2 Nov 2001 11:58:18 -0500
Received: from e23.nc.us.ibm.com ([32.97.136.229]:51099 "EHLO
	e23.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S280731AbRKBQ6I>; Fri, 2 Nov 2001 11:58:08 -0500
Date: Fri, 2 Nov 2001 08:58:03 -0800
From: Mike Kravetz <kravetz@us.ibm.com>
To: Hubertus Franke <frankeh@watson.ibm.com>
Cc: Davide Libenzi <davidel@xmailserver.org>,
        lkml <linux-kernel@vger.kernel.org>, lse-tech@lists.sourceforge.net
Subject: Re: [Lse-tech] Re: [PATCH][RFC] Proposal For A More Scalable Scheduler ...
Message-ID: <20011102085803.A1150@w-mikek2.des.beaverton.ibm.com>
In-Reply-To: <20011031151243.E1105@w-mikek2.des.beaverton.ibm.com> <Pine.LNX.4.40.0110311544330.1484-100000@blue1.dev.mcafeelabs.com> <20011102072036.D17792@watson.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011102072036.D17792@watson.ibm.com>; from frankeh@watson.ibm.com on Fri, Nov 02, 2001 at 07:20:36AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 02, 2001 at 07:20:36AM -0500, Hubertus Franke wrote:
> 
> One more. Throughout our MQ evaluation, it was also true that 
> the overall performance particularly for large thread counts was
> very sensitive to the goodness function, that why a na_goodness_local 
> was introduced.
> 

Correct, we did notice measurable differences in performance just
from the additional (unnecessary) checks in goodness.  Unfortunately,
the current version of MQ has 3 different (but similar) variations
of the goodness function.  This is UGLY, and I intend to clean this
up (without impacting performance of course :).

-- 
Mike
