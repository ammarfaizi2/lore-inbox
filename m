Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261683AbSKHGVm>; Fri, 8 Nov 2002 01:21:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266759AbSKHGVm>; Fri, 8 Nov 2002 01:21:42 -0500
Received: from pimout4-ext.prodigy.net ([207.115.63.103]:50120 "EHLO
	pimout4-ext.prodigy.net") by vger.kernel.org with ESMTP
	id <S261683AbSKHGVm> convert rfc822-to-8bit; Fri, 8 Nov 2002 01:21:42 -0500
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
Reply-To: landley@trommello.org
To: jw schultz <jw@pegasys.ws>, linux-kernel@vger.kernel.org
Subject: Re: Why are exe, cwd, and root priviledged bits of information?
Date: Fri, 8 Nov 2002 06:28:24 +0000
User-Agent: KMail/1.4.3
References: <Pine.LNX.4.33L2.0211071052540.8252-100000@rtlab.med.cornell.edu> <200211071641.01585.pollard@admin.navo.hpc.mil> <20021108015533.GC2249@pegasys.ws>
In-Reply-To: <20021108015533.GC2249@pegasys.ws>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200211080628.24210.landley@trommello.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 08 November 2002 01:55, jw schultz wrote:

> I painted with too broad a brush.  I apologize.
>
> I'm afraid i'll never consider shared secrets to be secure.

Don't use SSH then, or any SSL derivative.  They only use public key 
cryptography at the start of the session, primarily to exchange a pair of 
symmetric keys, which are then used to encrypt the bulk data transmitted 
during the rest of the session.

Public key cryptography is computationally expensive.  Symmetric key 
cryptography is quick and easy, and provably breakable only by brute force if 
you know they haven't got the key.

And of course, the data you're transmitting is itself a shared secret, isn't 
it?  At the end of the session, anyway.  That's the whole point.

> They may provide privacy but not security.

You can have security without privacy?

How?

Privacy is "necessary but not sufficient" to security.  All cryptography boils 
down to there being something you don't want somebody else to know.

Rob

-- 
http://penguicon.sf.net - Terry Pratchett, Eric Raymond, Pete Abrams, Illiad, 
CmdrTaco, liquid nitrogen ice cream, and caffienated jello.  Well why not?
