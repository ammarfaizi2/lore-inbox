Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279845AbRJ3EI2>; Mon, 29 Oct 2001 23:08:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279841AbRJ3EII>; Mon, 29 Oct 2001 23:08:08 -0500
Received: from cx97923-a.phnx3.az.home.com ([24.9.112.194]:12168 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S279843AbRJ3EH5>;
	Mon, 29 Oct 2001 23:07:57 -0500
Message-ID: <3BDE27BE.3569FE22@candelatech.com>
Date: Mon, 29 Oct 2001 21:08:30 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Kevin D. Wooten" <kwooten@home.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Module Licensing?
In-Reply-To: <01102920463500.03524@newton.cevio.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Kevin D. Wooten" wrote:
> 
> After reading the posts about the MODULE_LICENSE macro, I am in disbelief. I
> was under the impression that one could write a "closed-source" module and
> distribute it in binary form, and be in compliance. Please tell me I am
> wrong? We use Linux as a platform for some data acquisition, and we are
> currently distributing ( in very limited quantity to people who would already
> have signed an NDA ) modules that currently have no official license as yet.
> We are researching which license to use, but according to these post's we
> have almost no choice, Open Source or not at all!

No, you just can't use certain symbols if you're not GPL.  If your
code already works, then you're fine, as previously existing symbols
will not be thus restricted...  You can just make your MODULE_LICENSE == "mine-all-mine...including-all-my-bugs"

Ben

> 
> -kw
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear
