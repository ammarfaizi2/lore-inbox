Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285060AbSAPRng>; Wed, 16 Jan 2002 12:43:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285424AbSAPRn0>; Wed, 16 Jan 2002 12:43:26 -0500
Received: from holomorphy.com ([216.36.33.161]:39046 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S285369AbSAPRnO>;
	Wed, 16 Jan 2002 12:43:14 -0500
Date: Wed, 16 Jan 2002 09:42:26 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: hashed waitqueues
Message-ID: <20020116094226.A760@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Jamie Lokier <lk@tantalophile.demon.co.uk>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020104094049.A10326@holomorphy.com> <E16MeqE-0001Ea-00@starship.berlin> <20020104173923.B10391@holomorphy.com> <20020116142140.A31993@kushida.apsleyroad.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <20020116142140.A31993@kushida.apsleyroad.org>; from lk@tantalophile.demon.co.uk on Wed, Jan 16, 2002 at 02:21:41PM +0000
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2002 at 02:21:41PM +0000, Jamie Lokier wrote:
> Looking up "good hash function" on Google leads to these notable pages:
	[various URL's]
> The last one is interesting because it mentions the golden prime
> multiplier function, and suggests good non-multipler functions instead.
> (Justification: the multiplier function doesn't distribute bits evenly).

Excellent! I can always use more of these to test.

It seems odd that they don't like Fibonacci hashing, it appears to pass
various chi^2 tests on bucket distribution. And operator-sparse Fibonacci
hashing primes appear to pass it as well, at least once 10 terms of the
continued fraction match (operator-sparse Fibonacci hashing primes means
that the multiplication can be done with shifts and adds or subtracts).

Regardless, various arches want non-multiplicative hash functions and
they'll be getting them. These hash functions will certainly prove
useful in getting a broader base to test against. I don't care to have
a "pet" hash function, only one that is good as possible.


Thanks,
Bill
