Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316684AbSE1PB2>; Tue, 28 May 2002 11:01:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316747AbSE1PB1>; Tue, 28 May 2002 11:01:27 -0400
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:45806 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S316684AbSE1PB0>; Tue, 28 May 2002 11:01:26 -0400
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <15603.38007.42661.75173@kim.it.uu.se> 
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: "J.A. Magallon" <jamagallon@able.es>,
        Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
        Miles Bader <miles@gnu.org>, Keith Owens <kaos@ocs.com.au>,
        Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][RFC] PentiumPro/II split in x86 config 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 28 May 2002 16:00:57 +0100
Message-ID: <13519.1022598057@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


mikpe@csd.uu.se said:
>  They do implement inline asm() nowadays, but alas not &&label and
> computed gotos.

The only places I've seen &&label used are where it's been passed into an 
inline asm which has jumped to it... but gcc has optimised the label and 
the code following it away because it was never used (inline asm isn't 
allowed to do that).

--
dwmw2


