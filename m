Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267650AbRH1UHA>; Tue, 28 Aug 2001 16:07:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267534AbRH1UGu>; Tue, 28 Aug 2001 16:06:50 -0400
Received: from otter.mbay.net ([206.40.79.2]:18182 "EHLO otter.mbay.net")
	by vger.kernel.org with ESMTP id <S266806AbRH1UGp> convert rfc822-to-8bit;
	Tue, 28 Aug 2001 16:06:45 -0400
From: jalvo@mbay.net (John Alvord)
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: torvalds@transmeta.com (Linus Torvalds),
        viro@math.psu.edu (Alexander Viro), linux-kernel@vger.kernel.org
Subject: Re: [IDEA+RFC] Possible solution for min()/max() war
Date: Tue, 28 Aug 2001 20:06:23 GMT
Message-ID: <3b8bf989.1927813@mail.mbay.net>
In-Reply-To: <E15bgl2-0005oW-00@the-village.bc.nu>
In-Reply-To: <E15bgl2-0005oW-00@the-village.bc.nu>
X-Mailer: Forte Agent 1.5/32.451
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Aug 2001 12:10:12 +0100 (BST), Alan Cox
<alan@lxorguk.ukuu.org.uk> wrote:

>> Or, with the 2.4.9 approach, it's just a single macro (well, and another
>> one for "max()"). And when somebody needs a new type, he doesn't have to
>> worry about creating a new instantiation of the macro.
>
>The unfortunate thing is that its min and max as opposed to typed_min and
>typed_max (with min/max set up to error), since its now a nightmare to 
>maintain compatibility between two allegedly stable releases of the same
>kernel, as well as with 2.2
>
>Had it been typed_min(a,b,c) then 2.2 could have stayed compatible and the
>glue would have been simple

Does the new min/max definitions hurt portability to and from Linux?

john alvord
