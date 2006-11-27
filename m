Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757537AbWK0JPy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757537AbWK0JPy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 04:15:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757529AbWK0JPy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 04:15:54 -0500
Received: from 70-91-206-233-BusName-SFBA.hfc.comcastbusiness.net ([70.91.206.233]:1161
	"EHLO saville.com") by vger.kernel.org with ESMTP id S1757537AbWK0JPy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 04:15:54 -0500
Message-ID: <456AACC9.10206@saville.com>
Date: Mon, 27 Nov 2006 01:15:53 -0800
From: Wink Saville <wink@saville.com>
User-Agent: Thunderbird 1.5.0.8 (Windows/20061025)
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: Robert Hancock <hancockr@shaw.ca>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] x86: unify/rewrite SMP TSC sync code
References: <fa./NRPJg+JjfSQLUVwnX1GpHGIojQ@ifi.uio.no>	 <fa.Y0RKABHd+7qnbGQYBAGPvlJ0Qic@ifi.uio.no>	 <fa.fD3WSpNqEJ4736vYzEak5Gf3xTw@ifi.uio.no>	 <fa.A+gkQAO1DLThaxJxPLPl3yE1CGo@ifi.uio.no>	 <fa.INurNKWdUKAEULTHyfpSW65a/Ng@ifi.uio.no>	 <fa.n9vySiI9RS2MCl0DZPDzxZEPiFw@ifi.uio.no> <4569404E.20402@shaw.ca>	 <45694D6F.60100@saville.com>	 <1164529484.3147.68.camel@laptopd505.fenrus.org>	 <4569EF9D.7010802@saville.com> <1164613914.3276.10.camel@laptopd505.fenrus.org>
In-Reply-To: <1164613914.3276.10.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:

> just to make sure, you do realize that when you write "ticks" that rdtsc
> doesn't measure cpu clock ticks or cpu cycles anymore, right? (At least
> not on your machine)
> 

Yes, that's why I wrote ticks and not cycles. At this point I'm not sure how to convert
ticks to time on my machine, something else to learn:) Hopefully the HPET
will resolve all of the issues.

Wink

