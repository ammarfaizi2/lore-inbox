Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282018AbRKZSeO>; Mon, 26 Nov 2001 13:34:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282013AbRKZScv>; Mon, 26 Nov 2001 13:32:51 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:14855 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S282011AbRKZScB>; Mon, 26 Nov 2001 13:32:01 -0500
Date: Mon, 26 Nov 2001 15:14:33 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Olaf Hering <olh@suse.de>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH] net/802/Makefile
In-Reply-To: <20011126140645.B3014@suse.de>
Message-ID: <Pine.LNX.4.21.0111261514070.13961-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Olaf, 


Let the correction come to me through the 802 maintainer, please. 

On Mon, 26 Nov 2001, Olaf Hering wrote:

> Hi,
> 
> the build stops when cl2llc.c has no write permissions.
> 
> diff -urN linuxppc_2_4/net/802/Makefile.broken linuxppc_2_4/net/802/Makefile
> --- linuxppc_2_4/net/802/Makefile.broken        Mon Nov 26 13:28:56 2001
> +++ linuxppc_2_4/net/802/Makefile       Mon Nov 26 13:51:10 2001
> @@ -57,4 +57,5 @@
>  include $(TOPDIR)/Rules.make
>  
>  cl2llc.c: cl2llc.pre
> +       chmod u+w cl2llc.c
>         sed -f ./pseudo/opcd2num.sed cl2llc.pre >cl2llc.c
> 
> 
> 
> Gruss Olaf
> 
> -- 
>  $ man clone
> 
> BUGS
>        Main feature not yet implemented...
> 

