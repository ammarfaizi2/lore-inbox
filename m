Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129652AbQKZJxK>; Sun, 26 Nov 2000 04:53:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129663AbQKZJxB>; Sun, 26 Nov 2000 04:53:01 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:24580 "EHLO
        atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
        id <S129652AbQKZJwv>; Sun, 26 Nov 2000 04:52:51 -0500
Date: Sun, 26 Nov 2000 10:22:57 +0100
From: Martin Mares <mj@suse.cz>
To: Andries Brouwer <aeb@veritas.com>
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>,
        Herbert Xu <herbert@gondor.apana.org.au>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] removal of "static foo = 0"
Message-ID: <20001126102256.A21819@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20001125211939.A6883@veritas.com> <200011252211.eAPMBIo21200@gondor.apana.org.au> <20001125234624.A7049@veritas.com> <3A20451B.2A69BB75@mandrakesoft.com> <20001126030802.C7049@veritas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
In-Reply-To: <20001126030802.C7049@veritas.com>; from aeb@veritas.com on Sun, Nov 26, 2000 at 03:08:02AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andries!

> All these really good people, unable to capture a simple idea.
> Let me try one more time.
> There is information. The information is:
> 	"this variable needs initialization"
> Now you tell me to know simple rules. OK, I know them.
> But what do they tell me about my variables a and b, where
> a requires initialization and b does not require it?

Distinguishing between variables initialized to zero and those not requiring
initialization is a good idea, but honestly, how common are static variables
declared at the top level which don't require initialization? 

				Have a nice fortnight
-- 
Martin `MJ' Mares <mj@ucw.cz> <mj@suse.cz> http://atrey.karlin.mff.cuni.cz/~mj/
"RAM = Rarely Adequate Memory"
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
