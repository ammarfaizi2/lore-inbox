Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270201AbRIVRFV>; Sat, 22 Sep 2001 13:05:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271834AbRIVRFN>; Sat, 22 Sep 2001 13:05:13 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:21515 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S270201AbRIVRE5>;
	Sat, 22 Sep 2001 13:04:57 -0400
Date: Sat, 22 Sep 2001 14:05:08 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: axboe@suse.de (Jens Axboe), arjanv@redhat.com (Arjan van de Ven),
        torvalds@transmeta.com (Linus Torvalds),
        linux-kernel@vger.kernel.org (Linux Kernel),
        davem@redhat.com (David S. Miller)
Subject: Re: [patch] block highmem zero bounce v14
Message-ID: <20010922140508.D25990@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, axboe@suse.de (Jens Axboe),
	arjanv@redhat.com (Arjan van de Ven),
	torvalds@transmeta.com (Linus Torvalds),
	linux-kernel@vger.kernel.org (Linux Kernel),
	davem@redhat.com (David S. Miller)
In-Reply-To: <20010922183523.A6976@suse.de> <E15kpqc-0003fI-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <E15kpqc-0003fI-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Sat, Sep 22, 2001 at 05:41:46PM +0100
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sat, Sep 22, 2001 at 05:41:46PM +0100, Alan Cox escreveu:
> > Somehow I knew you would say that, Alan. 
> 
> I spent a lot of my time debugging driver code, and if its in one driver,
> its normally in ten. Look at the last serial driver fixup for example

I got some guys learning to hack the kernel, first task? write a
multiserial driver (new one for an old .br produced card by cyclades) that
doesn't uses BHs neither cli/sti, next task? You bet... 8) 2.5, were are
ya? come on... ;)

- Arnaldo
