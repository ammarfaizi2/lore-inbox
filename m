Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289941AbSAPOZ4>; Wed, 16 Jan 2002 09:25:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289942AbSAPOZh>; Wed, 16 Jan 2002 09:25:37 -0500
Received: from pc-62-31-92-140-az.blueyonder.co.uk ([62.31.92.140]:47834 "EHLO
	kushida.apsleyroad.org") by vger.kernel.org with ESMTP
	id <S289941AbSAPOZb>; Wed, 16 Jan 2002 09:25:31 -0500
Date: Wed, 16 Jan 2002 14:21:41 +0000
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org
Subject: Re: hashed waitqueues
Message-ID: <20020116142140.A31993@kushida.apsleyroad.org>
In-Reply-To: <20020104094049.A10326@holomorphy.com> <E16MeqE-0001Ea-00@starship.berlin> <20020104173923.B10391@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020104173923.B10391@holomorphy.com>; from wli@holomorphy.com on Fri, Jan 04, 2002 at 05:39:23PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
> I believe to address architectures where multiplication is prohibitively
> expensive I should do some reading to determine a set of theoretically
> sound candidates for non-multiplicative hash functions and benchmark them.
> Knuth has some general rules about design but I would rather merely test
> some already verified by someone else and use the one that benches best
> than duplicate the various historical efforts to find good hash functions.

Looking up "good hash function" on Google leads to these notable pages:

http://burtleburtle.net/bob/hash/doobs.html
	A Hash Function For Hash Table Lookup - Robert Jenkins
http://burtleburtle.net/bob/hash/
	Hash Functions and Block Ciphers - Robert Jenkins
http://www.concentric.net/~Ttwang/tech/inthash.htm
	Integer Hash Function - Thomas Wang

The last one is interesting because it mentions the golden prime
multiplier function, and suggests good non-multipler functions instead.
(Justification: the multiplier function doesn't distribute bits evenly).

enjoy,
-- Jamie
