Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314702AbSE1ODb>; Tue, 28 May 2002 10:03:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315440AbSE1OD3>; Tue, 28 May 2002 10:03:29 -0400
Received: from jalon.able.es ([212.97.163.2]:33224 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S314702AbSE1OD1>;
	Tue, 28 May 2002 10:03:27 -0400
Date: Tue, 28 May 2002 16:03:22 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
Cc: Miles Bader <miles@gnu.org>, Keith Owens <kaos@ocs.com.au>,
        Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][RFC] PentiumPro/II split in x86 config
Message-ID: <20020528140322.GA6320@werewolf.able.es>
In-Reply-To: <3937.1022552654@kao2.melbourne.sgi.com> <buo3cwdf0b0.fsf@mcspd15.ucom.lsi.nec.co.jp> <20020528030200.GL20729@conectiva.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.3.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2002.05.28 Arnaldo Carvalho de Melo wrote:
>Em Tue, May 28, 2002 at 11:55:47AM +0900, Miles Bader escreveu:
>> Keith Owens <kaos@ocs.com.au> writes:
>> > The kernel can only be compiled with gcc, but some bits of the build
>> > are compiled and run on the host, using the host compiler.  Avoid using
>> > gccisms where there is a standard way of doing it.
>> 
>> That particular gccism completely infests the kernel, so there seems
>> little point in avoiding it in favor of the uglier standard syntax.
>
>Agreed.
>
>What I'll do: continue using the simpler way that only gcc understands but
>take care to not use gccisms when and if I patch build bits.
>

Problem is that named initializers '.xx =' are ISO C99, so problably they
are not supported in gcc till 3.0...the old way is working with older
compilers.

-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Mandrake Linux release 8.3 (Cooker) for i586
Linux werewolf 2.4.19-pre8-jam4 #2 SMP dom may 26 11:20:42 CEST 2002 i686
