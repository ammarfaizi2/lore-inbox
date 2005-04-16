Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261778AbVDPLox@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261778AbVDPLox (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Apr 2005 07:44:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262651AbVDPLox
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Apr 2005 07:44:53 -0400
Received: from science.horizon.com ([192.35.100.1]:11844 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S261778AbVDPLou
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Apr 2005 07:44:50 -0400
Date: 16 Apr 2005 11:44:50 -0000
Message-ID: <20050416114450.29351.qmail@science.horizon.com>
From: linux@horizon.com
To: daw@taverner.cs.berkeley.edu
Subject: Re: Fortuna
Cc: jlcooke@certainkey.com, linux@horizon.com, linux-kernel@vger.kernel.org,
       mpm@selenic.com, tytso@mit.edu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> /dev/urandom depends on the strength of the crypto primitives.
>> /dev/random does not.  All it needs is a good uniform hash.
> 
> That's not at all clear.  I'll go farther: I think it is unlikely
> to be true.
> 
> If you want to think about cryptographic primitives being arbitrarily
> broken, I think there will be scenarios where /dev/random is insecure.
> 
> As for what you mean by "good uniform hash", I think you'll need to
> be a bit more precise.

Well, you just pointed me to a very nice paper that *makes* it precise:

Boaz Barak, Ronen Shaltiel, and Eran Tromer. True random number generators
secure in a changing environment. In Workshop on Cryptographic Hardware
and Embedded Systems (CHES), pages 166-180, 2003. LNCS no. 2779.

I haven't worked through all the proofs yet, but it looks to be highly
applicable.

>> Do a bit of reading on the subject of "unicity distance".
> 
> Yes, I've read Shannon's original paper on the subject, as well
> as many other treatments.

I hope it's obvious that I didn't mean to patronize *you* with such
a suggestion!  Clearly, you're intimately familiar with the concept,
and any discussion can go straight on to more detailed issues.

I just hope you'll grant me that understanding the concept is pretty
fundamental to any meaningful discussion of information-theoretic
security.

> I stand by my comments above.

Cool!  So there's a problem to be solved!
