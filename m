Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136058AbREGNyG>; Mon, 7 May 2001 09:54:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136091AbREGNx4>; Mon, 7 May 2001 09:53:56 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:50449 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S136058AbREGNxv>; Mon, 7 May 2001 09:53:51 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: page_launder() bug
Date: 7 May 2001 06:53:44 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9d69d8$g9f$1@cesium.transmeta.com>
In-Reply-To: <15094.10942.592911.70443@pizda.ninka.net> <Pine.LNX.4.33.0105070823060.24073-100000@svea.tellus>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <Pine.LNX.4.33.0105070823060.24073-100000@svea.tellus>
By author:    Tobias Ringstrom <tori@tellus.mine.nu>
In newsgroup: linux.dev.kernel
>
> On Sun, 6 May 2001, David S. Miller wrote:
> > It is the most straightforward way to make a '1' or '0'
> > integer from the NULL state of a pointer.
> 
> But is it really specified in the C "standards" to be exctly zero or one,
> and not zero and non-zero?
> 

Yes it is.

> 
> IMHO, the ?: construct is way more readable and reliable.
> 

In C99 one can write (bool)foo which is more readable than either,
especially since that is really what one is trying to do.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
