Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316653AbSE0PSM>; Mon, 27 May 2002 11:18:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316655AbSE0PSL>; Mon, 27 May 2002 11:18:11 -0400
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:10735 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S316653AbSE0PSK>; Mon, 27 May 2002 11:18:10 -0400
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <20020527150048.GC6738@werewolf.able.es> 
To: "J.A. Magallon" <jamagallon@able.es>
Cc: Lista Linux-Kernel <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: [PATCH][RFC] gcc3 arch options 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 27 May 2002 16:18:00 +0100
Message-ID: <27362.1022512680@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


jamagallon@able.es said:
> +CFLAGS += $(shell if $(CC) -march=pentium-mmx -S -o /dev/null -xc /
> dev/null >/dev/null 2>&1; then echo "-march=pentium-mmx"; else echo
> "-march=i586"; fi)

Doesn't this run the shell command every time $(CFLAGS) is used?

--
dwmw2


