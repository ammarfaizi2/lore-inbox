Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269926AbRIEBAY>; Tue, 4 Sep 2001 21:00:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269967AbRIEBAO>; Tue, 4 Sep 2001 21:00:14 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:37137 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S269926AbRIEBAC>; Tue, 4 Sep 2001 21:00:02 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Advice on Unsigned Types
Date: 4 Sep 2001 18:00:19 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9n3tf3$ffq$1@cesium.transmeta.com>
In-Reply-To: <3B8EF269.BF457C7F@home.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <3B8EF269.BF457C7F@home.com>
By author:    John Kacur <jkacur@home.com>
In newsgroup: linux.dev.kernel
> 
> The advice the author give on Unsigned Types is:
> "Avoid unnecessary complexity by minimizing your use of unsigned types.
> Specifically, don't use an unsigned type to represent a quantity just
> because it will never be negative (e.g."age" or "national debt").
> Use a signed type like int and you won't have to worry about boundary
> cases in the detailed rules for promoting mixed types.
> Only use unsigned types for bitfields or binary masks. Use casts in
> expressions, to make all the operands signed or unsigned, so the
> compiler does not have to choose the result type."
> 

So the author isn't talking about developing operating systems.  In
operating systems it's almost the other way around -- signed is really
the exception.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
