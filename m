Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315285AbSGWXgW>; Tue, 23 Jul 2002 19:36:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316614AbSGWXgW>; Tue, 23 Jul 2002 19:36:22 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:33032 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S315285AbSGWXgU>; Tue, 23 Jul 2002 19:36:20 -0400
Date: Tue, 23 Jul 2002 19:46:03 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: Eero Volotinen <ev@kernel.ping-viini.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: crash 2.4.19-rc3 on smp machine.
In-Reply-To: <000b01c23005$fef760f0$0200a8c0@eero>
Message-ID: <Pine.LNX.4.44.0207231945500.30493-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Could you decode the oops with ksymoops please?

On Sat, 20 Jul 2002, Eero Volotinen wrote:

> Jul 20 15:02:06 gw kernel: kernel BUG at page_alloc.c:220!
> Jul 20 15:02:06 gw kernel: invalid operand: 0000
> Jul 20 15:02:06 gw kernel: CPU:    1
> Jul 20 15:02:06 gw kernel: EIP:    0010:[<c013147e>]    Not tainted
> Jul 20 15:02:06 gw kernel: EFLAGS: 00010202
> Jul 20 15:02:06 gw kernel: eax: 00000040   ebx: c149d2f8   ecx: 00001000
> edx: 0001ad85
> Jul 20 15:02:06 gw kernel: esi: c02968d4   edi: 0001effd   ebp: 0001effd
> esp: dad8fe3c
> Jul 20 15:02:06 gw kernel: ds: 0018   es: 0018   ss: 0018
> Jul 20 15:02:06 gw kernel: Process run (pid: 30135, stackpage=dad8f000)
> Jul 20 15:02:06 gw kernel: Stack: 00001000 00019d85 00000296 00000000
> c02968d4 c0296a60 000001ff 00000000
> Jul 20 15:02:06 gw kernel:        c149d63c c0131711 c02968d4 c0296a5c
> 000001d2 dad8e000 00000000 00000000
> Jul 20 15:02:06 gw kernel:        00000001 c149d63c c0126602 c0126c1d
> dcdffd40 08074000 00000000 dbae76c0
> Jul 20 15:02:06 gw kernel: Call Trace:    [<c0131711>] [<c0126602>]
> [<c0126c1d>] [<c0126e0d>] [<c01211e6>]
> Jul 20 15:02:06 gw kernel:   [<c0113a6a>] [<c01272ca>] [<c01138b0>]
> [<c0108c0c>]
> Jul 20 15:02:06 gw kernel:
> Jul 20 15:02:06 gw kernel: Code: 0f 0b dc 00 e3 84 25 c0 8b 43 18 a9 80 00
> 00 00 74 08 0f 0b
> Jul 20 15:02:07 gw kernel:  kernel BUG at page_alloc.c:220!
> Jul 20 15:02:07 gw kernel: invalid operand: 0000
> Jul 20 15:02:07 gw kernel: CPU:    1
> Jul 20 15:02:07 gw kernel: EIP:    0010:[<c013147e>]    Not tainted
> Jul 20 15:02:07 gw kernel: EFLAGS: 00010202
>
> ..
>
> --
> Eero
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

