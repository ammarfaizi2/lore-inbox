Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288231AbSAHSpP>; Tue, 8 Jan 2002 13:45:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288227AbSAHSpG>; Tue, 8 Jan 2002 13:45:06 -0500
Received: from holomorphy.com ([216.36.33.161]:33240 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S288231AbSAHSo4>;
	Tue, 8 Jan 2002 13:44:56 -0500
Date: Tue, 8 Jan 2002 10:44:26 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Roland Dreier <roland@topspincom.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: hashed waitqueues
Message-ID: <20020108104426.U10326@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Roland Dreier <roland@topspincom.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20020104094049.A10326@holomorphy.com> <E16MeqE-0001Ea-00@starship.berlin> <20020104173923.B10391@holomorphy.com> <E16Mgoj-0001Ew-00@starship.berlin> <20020104210611.C10391@holomorphy.com> <20020108102037.J10391@holomorphy.com> <20020108102723.K10391@holomorphy.com> <523d1gu1ni.fsf@love-boat.topspincom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <523d1gu1ni.fsf@love-boat.topspincom.com>; from roland@topspincom.com on Tue, Jan 08, 2002 at 10:40:33AM -0800
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William> On Tue, Jan 08, 2002 at 10:20:37AM -0800, William Lee Irwin III wrote:
>> The (theoretically) best 64-bit prime with 5 high bits I found is:
William> 	[numbers]
>> and the (theoretically) best 64-bit prime with 4 high bits I found is:
William> 	[numbers]
William> Sorry, I forgot to credit my helpers in the last post:
William> The sieving technique to find these things was devised by
William> Christophe Rhodes <csr21@cam.ac.uk> and fare@tunes.org

On Tue, Jan 08, 2002 at 10:40:33AM -0800, Roland Dreier wrote:
> Just out of curiousity, why do you need a "sieving technique" to find
> these primes?  There are only 63 choose 4 (which is 595665) 64 bit
> numbers with only 5 bits set, of which probably no more than 15000 are
> prime, so it seems you could just test all of them.  What am I missing?

The sieving technique they devised uses that. In fact, they search only
2*choose(59,2), as bits 63, 0, and one of either 60 or 61 must be set,
since it must be odd to be prime and bits 63 -> 60 are determined by
(up to the choice of either 60 or 61) by 4/7 <= p/2^64 <= 2/3.


Cheers,
Bill
