Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318719AbSIKLc1>; Wed, 11 Sep 2002 07:32:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318721AbSIKLc1>; Wed, 11 Sep 2002 07:32:27 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:11792 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S318719AbSIKLc0>; Wed, 11 Sep 2002 07:32:26 -0400
Date: Wed, 11 Sep 2002 07:50:07 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: Adrian Bunk <bunk@fs.tum.de>
Cc: johnstul@us.ibm.com, <linux-kernel@vger.kernel.org>
Subject: Re: [patch] add "If unsure, say N" to CONFIG_X86_TSC_DISABLE
In-Reply-To: <Pine.NEB.4.44.0209102247150.18902-100000@mimas.fachschaften.tu-muenchen.de>
Message-ID: <Pine.LNX.4.44.0209110746150.28789-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 10 Sep 2002, Adrian Bunk wrote:

> Hi Marcelo,
>
> the patch below does:
> - add a "If unsure, say N" to CONFIG_X86_TSC_DISABLE
> - fix two typos

Thanks, will apply.

> --- Documentation/Configure.help.old	2002-09-10 22:38:42.000000000 +0200
> +++ Documentation/Configure.help	2002-09-10 22:49:21.000000000 +0200
> @@ -240,9 +240,11 @@
>    which processor you have compiled for.
>
>    NOTE: If your system hangs when init should run, you are probably
> -  using a i686 compiled glibc which reads the TSC wihout checking for
> -  avaliability. Boot without "notsc" and install a i386 compiled glibc
> +  using a i686 compiled glibc which reads the TSC without checking for
> +  availability. Boot without "notsc" and install a i386 compiled glibc
>    to solve the problem.
> +
> +  If unsure, say N.

Could you please generate patches between two full trees including the
root name (eg. linux/Documentation/Configure.help) next time?

Its easier for me this way.


