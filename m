Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271825AbRISTPe>; Wed, 19 Sep 2001 15:15:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274139AbRISTPY>; Wed, 19 Sep 2001 15:15:24 -0400
Received: from zikova.cvut.cz ([147.32.235.100]:29445 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S271825AbRISTPE>;
	Wed, 19 Sep 2001 15:15:04 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Arjan van de Ven <arjanv@redhat.com>
Date: Wed, 19 Sep 2001 21:15:17 MET-1
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: [PATCH] Athlon bug stomper. Pls apply.
CC: linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.40
Message-ID: <3EDB9E14576@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 19 Sep 01 at 19:55, Arjan van de Ven wrote:
> 
> Ok but that part is simple:
> 
> run
> 
> http://www.fenrus.demon.nl/athlon.c

Small question - is it OK that 'faster_copy' is faster than
'even_faster'? By only few percents, but... It is dual cpu Tyan,
with two AMD MP 1.2MHz, with 1022:700C AMD hostbridge. I'll
check KT133 at home if I'll remember...
                                        Thanks,
                                                Petr Vandrovec
                                                vandrove@vc.cvut.cz
                                                

Athlon test program $Id: fast.c,v 1.6 2000/09/23 09:05:45 arjan Exp $ 
clear_page() tests 
clear_page function 'warm up run'    took 13967 cycles per page
clear_page function '2.4 non MMX'    took 9298 cycles per page
clear_page function '2.4 MMX fallback'   took 9284 cycles per page
clear_page function '2.4 MMX version'    took 8508 cycles per page
clear_page function 'faster_clear_page'  took 4016 cycles per page
clear_page function 'even_faster_clear'  took 3916 cycles per page

copy_page() tests 
copy_page function 'warm up run'     took 15118 cycles per page
copy_page function '2.4 non MMX'     took 17002 cycles per page
copy_page function '2.4 MMX fallback'    took 16978 cycles per page
copy_page function '2.4 MMX version'     took 15163 cycles per page
copy_page function 'faster_copy'     took 8569 cycles per page
copy_page function 'even_faster'     took 8805 cycles per page
