Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131494AbRCWWh1>; Fri, 23 Mar 2001 17:37:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131489AbRCWWgJ>; Fri, 23 Mar 2001 17:36:09 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:10259 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S131493AbRCWWfT>; Fri, 23 Mar 2001 17:35:19 -0500
Date: Fri, 23 Mar 2001 14:34:15 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Bill Wendling <wendling@ganymede.isdn.uiuc.edu>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        "J . A . Magallon" <jamagallon@able.es>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] gcc-3.0 warnings
In-Reply-To: <20010323162956.A27066@ganymede.isdn.uiuc.edu>
Message-ID: <Pine.LNX.4.31.0103231433380.766-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 23 Mar 2001, Bill Wendling wrote:

> Also sprach Alan Cox:
>
> } > -	default:
> } > +	default:;
> }
> } Agree - done
> }
> This kind of coding makes me want to cry. What's so wrong with:
>
> 	default:
> 		break;
>
> instead? The ';' is hard to notice and

I agree. I'd much prefer that syntax also.

Or just remove the "default:" altogether, when it doesn't make any
difference.

		Linus

