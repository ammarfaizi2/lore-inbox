Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135404AbREBQ7F>; Wed, 2 May 2001 12:59:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135658AbREBQ6z>; Wed, 2 May 2001 12:58:55 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:45067 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S135404AbREBQ6m>; Wed, 2 May 2001 12:58:42 -0400
Date: Wed, 2 May 2001 13:58:24 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Pavel Roskin <proski@gnu.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.4.4-ac3 +IPX -SYSCTL compile fix
Message-ID: <20010502135823.C1261@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Pavel Roskin <proski@gnu.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0105021040120.921-100000@fonzie.nine.com> <Pine.LNX.4.33.0105021115090.8687-100000@fonzie.nine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <Pine.LNX.4.33.0105021115090.8687-100000@fonzie.nine.com>; from proski@gnu.org on Wed, May 02, 2001 at 11:17:22AM -0400
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, May 02, 2001 at 11:17:22AM -0400, Pavel Roskin escreveu:
> > +#error This file shouldn't be compiled without CONFIG_SYSCTL defined
> 
> Oops, sorry! Unterminated string constant in preprocessor. It should be
> 
> #error This file should not be compiled without CONFIG_SYSCTL defined
> 
> The patch at http://www.red-bean.com/~proski/linux/ipxsysctl.diff has been
> updated.

ok, I'm looking at this and including in the patch I'm about to send.

- Arnaldo
