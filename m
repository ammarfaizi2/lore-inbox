Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272058AbRHVR1o>; Wed, 22 Aug 2001 13:27:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272049AbRHVR1e>; Wed, 22 Aug 2001 13:27:34 -0400
Received: from barbados.bluemug.com ([63.195.182.101]:10514 "EHLO
	barbados.bluemug.com") by vger.kernel.org with ESMTP
	id <S272056AbRHVR1c>; Wed, 22 Aug 2001 13:27:32 -0400
Date: Wed, 22 Aug 2001 10:27:40 -0700
To: Robert Love <rml@tech9.net>
Cc: Oliver Xymoron <oxymoron@waste.org>, linux-kernel@vger.kernel.org,
        riel@conectiva.com.br
Subject: Re: [PATCH] let Net Devices feed Entropy, updated (1/2)
Message-ID: <20010822102740.D27313@bluemug.com>
Mail-Followup-To: Robert Love <rml@tech9.net>,
	Oliver Xymoron <oxymoron@waste.org>, linux-kernel@vger.kernel.org,
	riel@conectiva.com.br
In-Reply-To: <Pine.LNX.4.30.0108182234250.31188-100000@waste.org> <998193404.653.12.camel@phantasy> <20010821231002.C27313@bluemug.com> <998461609.5166.10.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <998461609.5166.10.camel@phantasy>
X-PGP-ID: 5C09BB33
X-PGP-Fingerprint: C518 67A5 F5C5 C784 A196  B480 5C97 3BBD 5C09 BB33
From: Mike Touloumtzis <miket@bluemug.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 22, 2001 at 02:26:36AM -0400, Robert Love wrote:
> 
> The solution to this is easy: get something to generate entropy (like my
> netdev patch! :) and save/restore the entropy seed.

Agreed, I don't think the netdev patch is a bad idea, and it's
helpful in the case I described.  I was just getting worried
about the assertions (from various directions) that /dev/random
and /dev/urandom are practically indistinguishable unless you
can break SHA-1.  There's enough confusion out there as it is :-).

miket
