Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264495AbRFQDDV>; Sat, 16 Jun 2001 23:03:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264684AbRFQDDN>; Sat, 16 Jun 2001 23:03:13 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:18187 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S264495AbRFQDC4>;
	Sat, 16 Jun 2001 23:02:56 -0400
Date: Sun, 17 Jun 2001 00:01:05 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Bill Pringlemeir <bpringle@sympatico.ca>, linux-kernel@vger.kernel.org
Subject: Re: Newbie idiotic questions.
Message-ID: <20010617000105.A940@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	"Richard B. Johnson" <root@chaos.analogic.com>,
	Bill Pringlemeir <bpringle@sympatico.ca>,
	linux-kernel@vger.kernel.org
In-Reply-To: <m2d78352do.fsf@sympatico.ca> <Pine.LNX.3.95.1010616212729.14170A-100000@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <Pine.LNX.3.95.1010616212729.14170A-100000@chaos.analogic.com>; from root@chaos.analogic.com on Sat, Jun 16, 2001 at 09:35:34PM -0400
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sat, Jun 16, 2001 at 09:35:34PM -0400, Richard B. Johnson escreveu:
> > [main.c, line 223]
> > 	if ((card->mpuout = kmalloc(sizeof(struct emu10k1_mpuout), GFP_KERNEL))
> > 
> > Why is the struct type referenced for the allocation size?  Why not,
> > 
> > 	if ((card->mpuout = kmalloc(sizeof(card->mpuout), GFP_KERNEL))
> > 
> > This seems to get the size for the actual object being allocated.
> > 
> 
> Again, you are correct. However, you may not know the history of the
> driver. Perhaps at one time the above statement was correct.

yes, and in fact this should be one of the entries in the kernel Janitor's
TODO list, please take a look at http://bazar.conectiva.com.br/~acme/TODO
and consider submitting some more things to cleanup so that people wanting
to start hacking the kernel can have some easy starting points. Also please
consider reading http://kernel-janitor.sourceforge.net

- Arnaldo
