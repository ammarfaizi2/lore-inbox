Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274180AbRISUwf>; Wed, 19 Sep 2001 16:52:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274182AbRISUw0>; Wed, 19 Sep 2001 16:52:26 -0400
Received: from mail.pha.ha-vel.cz ([195.39.72.3]:34313 "HELO
	mail.pha.ha-vel.cz") by vger.kernel.org with SMTP
	id <S274180AbRISUwL>; Wed, 19 Sep 2001 16:52:11 -0400
Date: Wed, 19 Sep 2001 22:52:34 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
Cc: Arjan van de Ven <arjanv@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Athlon bug stomper. Pls apply.
Message-ID: <20010919225234.C3775@suse.cz>
In-Reply-To: <3EDB9E14576@vcnet.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3EDB9E14576@vcnet.vc.cvut.cz>; from VANDROVE@vc.cvut.cz on Wed, Sep 19, 2001 at 09:15:17PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 19, 2001 at 09:15:17PM +0000, Petr Vandrovec wrote:
> On 19 Sep 01 at 19:55, Arjan van de Ven wrote:
> > 
> > Ok but that part is simple:
> > 
> > run
> > 
> > http://www.fenrus.demon.nl/athlon.c
> 
> Small question - is it OK that 'faster_copy' is faster than
> 'even_faster'? By only few percents, but... It is dual cpu Tyan,
> with two AMD MP 1.2MHz, with 1022:700C AMD hostbridge. I'll
> check KT133 at home if I'll remember...

Same here. In a quite number of cases, even_faster is actually slower.
Not always, though. I suspect the measurement is not really exact.

>                                         Thanks,
>                                                 Petr Vandrovec
>                                                 vandrove@vc.cvut.cz
>                                                 
> 
> Athlon test program $Id: fast.c,v 1.6 2000/09/23 09:05:45 arjan Exp $ 
> clear_page() tests 
> clear_page function 'warm up run'    took 13967 cycles per page
> clear_page function '2.4 non MMX'    took 9298 cycles per page
> clear_page function '2.4 MMX fallback'   took 9284 cycles per page
> clear_page function '2.4 MMX version'    took 8508 cycles per page
> clear_page function 'faster_clear_page'  took 4016 cycles per page
> clear_page function 'even_faster_clear'  took 3916 cycles per page
> 
> copy_page() tests 
> copy_page function 'warm up run'     took 15118 cycles per page
> copy_page function '2.4 non MMX'     took 17002 cycles per page
> copy_page function '2.4 MMX fallback'    took 16978 cycles per page
> copy_page function '2.4 MMX version'     took 15163 cycles per page
> copy_page function 'faster_copy'     took 8569 cycles per page
> copy_page function 'even_faster'     took 8805 cycles per page
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Vojtech Pavlik
SuSE Labs
