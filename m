Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317976AbSGLBl7>; Thu, 11 Jul 2002 21:41:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317975AbSGLBl6>; Thu, 11 Jul 2002 21:41:58 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:55567 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S317974AbSGLBlx>; Thu, 11 Jul 2002 21:41:53 -0400
Date: Thu, 11 Jul 2002 22:44:35 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Andrew Morton <akpm@zip.com.au>
Cc: Thunder from the hill <thunder@ngforever.de>,
       Dawson Engler <engler@csl.Stanford.EDU>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       mc@cs.Stanford.EDU
Subject: Re: [CHECKER] 56 potential lock/unlock bugs in 2.5.8
Message-ID: <20020712014435.GL9541@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Andrew Morton <akpm@zip.com.au>,
	Thunder from the hill <thunder@ngforever.de>,
	Dawson Engler <engler@csl.Stanford.EDU>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	mc@cs.Stanford.EDU
References: <200207112135.OAA03801@csl.Stanford.EDU> <Pine.LNX.4.44.0207111711530.26269-100000@hawkeye.luckynet.adm> <3D2E211E.24CF19B0@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D2E211E.24CF19B0@zip.com.au>
User-Agent: Mutt/1.4i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Jul 11, 2002 at 05:21:50PM -0700, Andrew Morton escreveu:
> Thunder from the hill wrote:
> > Here is the whole set.
 
> It's fair enough for a fix I guess.  But careful readers will
> have observed that a goodly portion of these bugs are directly
> due to the poor programming practice of putting more than one
> return statement in a C function.

woohooo!

"gotos considered !harmful"

8)

<asbestos suit>
- Arnaldo (that will continue putting more gotos in the kernel (hopefully)
           where they make sense, _clarifying_ the code and making it
           more maintainable 8) )
</asbestos suit>
