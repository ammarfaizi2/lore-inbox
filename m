Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311871AbSE1DCE>; Mon, 27 May 2002 23:02:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312169AbSE1DCD>; Mon, 27 May 2002 23:02:03 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:56583 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S311871AbSE1DCD>; Mon, 27 May 2002 23:02:03 -0400
Date: Tue, 28 May 2002 00:02:00 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Miles Bader <miles@gnu.org>
Cc: Keith Owens <kaos@ocs.com.au>,
        Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][RFC] PentiumPro/II split in x86 config
Message-ID: <20020528030200.GL20729@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Miles Bader <miles@gnu.org>, Keith Owens <kaos@ocs.com.au>,
	Lista Linux-Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <3937.1022552654@kao2.melbourne.sgi.com> <buo3cwdf0b0.fsf@mcspd15.ucom.lsi.nec.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, May 28, 2002 at 11:55:47AM +0900, Miles Bader escreveu:
> Keith Owens <kaos@ocs.com.au> writes:
> > The kernel can only be compiled with gcc, but some bits of the build
> > are compiled and run on the host, using the host compiler.  Avoid using
> > gccisms where there is a standard way of doing it.
> 
> That particular gccism completely infests the kernel, so there seems
> little point in avoiding it in favor of the uglier standard syntax.

Agreed.

What I'll do: continue using the simpler way that only gcc understands but
take care to not use gccisms when and if I patch build bits.

- Arnaldo
