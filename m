Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267937AbTAHVAZ>; Wed, 8 Jan 2003 16:00:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267938AbTAHVAY>; Wed, 8 Jan 2003 16:00:24 -0500
Received: from dhcp024-209-039-102.neo.rr.com ([24.209.39.102]:14215 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id <S267937AbTAHVAW>;
	Wed, 8 Jan 2003 16:00:22 -0500
Date: Wed, 8 Jan 2003 16:09:39 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: "Ruslan U. Zakirov" <cubic@miee.ru>
Cc: Zwane Mwaikambo <zwane@holomorphy.com>, Jaroslav Kysela <perex@perex.cz>,
       linux-kernel@vger.kernel.org
Subject: Re: [2.5.54][PATCH] SB16 convertation to new PnP layer.
Message-ID: <20030108160939.GA17701@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	"Ruslan U. Zakirov" <cubic@miee.ru>,
	Zwane Mwaikambo <zwane@holomorphy.com>,
	Jaroslav Kysela <perex@perex.cz>, linux-kernel@vger.kernel.org
References: <Pine.BSF.4.05.10301081959130.88742-100000@wildrose.miee.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.BSF.4.05.10301081959130.88742-100000@wildrose.miee.ru>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 08, 2003 at 08:20:13PM +0300, Ruslan U. Zakirov wrote:
> Hello Adam and All.
> Here is patch to sb16.c that makes it posible to compile and use this
> driver under 2.5.54-vanilla.
> It working for me as module and built in kernel, but it's need testing.
>                             Ruslan. 

Hi Ruslan,

I haven't had a chance to test this yet but everything does look ok.  I
think it will be ready once the below function is completed.  Jaroslav,
any comments?  Also, if anyone has a built in wavetable, as previously
mentioned by Zwane, I'd like to hear how this patch works for you.  This
patch makes full use of pnp card services, which is prefered for cards
that have several closely related devices, and it would be great to 
further test those code paths.

Thanks,
Adam

>
> -#endif /* __ISAPNP__ */
> +static void snd_sb16_isapnp_remove(struct pnp_card * card)
> +{
> +	/*FIX ME*/
> +}
> +
>
