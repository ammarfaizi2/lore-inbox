Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129029AbQKAOr3>; Wed, 1 Nov 2000 09:47:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129265AbQKAOrU>; Wed, 1 Nov 2000 09:47:20 -0500
Received: from TRAMPOLINE.THUNK.ORG ([216.175.175.172]:29958 "EHLO
	trampoline.thunk.org") by vger.kernel.org with ESMTP
	id <S129029AbQKAOrG>; Wed, 1 Nov 2000 09:47:06 -0500
Date: Wed, 1 Nov 2000 09:46:19 -0500
From: tytso@mit.edu
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: Jakub Jelinek <jakub@redhat.com>,
        Horst von Brand <vonbrand@sleipnir.valparaiso.cl>,
        linux-kernel@vger.kernel.org
Subject: Re: 2.4.0-test10-pre6: Use of abs()
Message-ID: <20001101094619.A15283@trampoline.thunk.org>
In-Reply-To: <200010281629.e9SGTah07672@sleipnir.valparaiso.cl> <39FD7F2C.9A3F3976@evision-ventures.com> <20001030081938.K6207@devserv.devel.redhat.com> <39FD9E6A.AD10E699@evision-ventures.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <39FD9E6A.AD10E699@evision-ventures.com>; from dalecki@evision-ventures.com on Mon, Oct 30, 2000 at 05:14:34PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2000 at 05:14:34PM +0100, Martin Dalecki wrote:
> Of corse right! BTW. There are tons of places where log2 is calculated
> explicitly in kernel which should be replaced with the corresponding
> built 
> in functions as well (/dev/random code does it). And then If I remember
> correctly
> there is an attribute which is telling about internal functions
> in declarations explicitly as well?

What versions of gcc produce the built-in functions?  And does it do
so for *all* platforms?  (i.e., PPC, Alpha, IA64, etc., etc., etc.)

						- Ted

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
