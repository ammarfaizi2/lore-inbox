Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132636AbRDKQsb>; Wed, 11 Apr 2001 12:48:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132643AbRDKQsV>; Wed, 11 Apr 2001 12:48:21 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:48654 "HELO
	postfix.conectiva.com.br") by vger.kernel.org with SMTP
	id <S132636AbRDKQsK>; Wed, 11 Apr 2001 12:48:10 -0400
Date: Wed, 11 Apr 2001 10:29:52 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: alan@lxorguk.ukuu.org.uk, 5740@mail.ru, linux-kernel@vger.kernel.org
Subject: Re: 2.4.3 compile error No 3
Message-ID: <20010411102952.D14114@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Petr Vandrovec <vandrove@vc.cvut.cz>, alan@lxorguk.ukuu.org.uk,
	5740@mail.ru, linux-kernel@vger.kernel.org
In-Reply-To: <4AB83BD5FB4@vcnet.vc.cvut.cz> <20010411180235.A29195@vana.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <20010411180235.A29195@vana.vc.cvut.cz>; from vandrove@vc.cvut.cz on Wed, Apr 11, 2001 at 06:02:35PM +0200
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Apr 11, 2001 at 06:02:35PM +0200, Petr Vandrovec escreveu:
> > # CONFIG_IPX_INTERN is not set
> > # CONFIG_SYSCTL is not set
> 
> > net/network.o: In function `ipx_init':
> > net/network.o(.text.init+0x1008): undefined reference to `ipx_register_sysctl'
> 
> Do not do it! You cannot control some very important features of IPX without
> sysctl! Anyway below is patch, Alan please apply (although I must say that

pprop broadcasting? 8) I was about to make a patch for this where it would be
possible to get rid of the sysctl stuff if the user choose not to have
it...

- Arnaldo

PS.: Next patch will have the routing sysctl 8)
