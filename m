Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129535AbQLHRTo>; Fri, 8 Dec 2000 12:19:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129639AbQLHRTe>; Fri, 8 Dec 2000 12:19:34 -0500
Received: from Cantor.suse.de ([194.112.123.193]:30732 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S129535AbQLHRTW>;
	Fri, 8 Dec 2000 12:19:22 -0500
Date: Fri, 8 Dec 2000 17:48:52 +0100
From: Andi Kleen <ak@suse.de>
To: kuznet@ms2.inr.ac.ru
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: Networking: RFC1122 and 1123 status for kernel 2.4
Message-ID: <20001208174852.A21884@gruyere.muc.suse.de>
In-Reply-To: <20001208165855.A20706@gruyere.muc.suse.de> <200012081641.TAA16371@ms2.inr.ac.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200012081641.TAA16371@ms2.inr.ac.ru>; from kuznet@ms2.inr.ac.ru on Fri, Dec 08, 2000 at 07:41:22PM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 08, 2000 at 07:41:22PM +0300, kuznet@ms2.inr.ac.ru wrote:
> /**
>  *	kfree_skb - free an sk_buff
>  *	@skb: buffer to free
>  *
>  *	Drop a reference to the buffer and free it if the usage count has
>  *	hit zero.
>  */
> 
> People, who need _literal_ translation from C to English to understand
> two lines of code, really exist in the nature? To be honest, I would not ever
> understand what is to "drop a reference to the buffer and free it
> if the usage count has hit zero" not looking to code. 8)

The idea is that they can be read externally (generated using make 
(ps|html|pdf)docs into Documentation/DocBook). Some people have a irrational
problem with RTFS and prefer to read external documentation @)

> 
> Seven times:
> 
>  *	If this function is called from an interrupt gfp_mask() must be
>  *	%GFP_ATOMIC.
> 
> Deep thought, of course. Deep enough to be repeated in each place,
> where gfp is used. 8)
> 
> Well, I am a fossil, of course, and like to read sources printed on paper
> and all these pretentions to convert readbale text to hypertext irritate me.
> But such deep thoughts eat even more expensive space on screen!

So write a 4 line perl script to filter them out before printing ? 

-Andi
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
