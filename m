Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265450AbRF1AOw>; Wed, 27 Jun 2001 20:14:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265451AbRF1AOm>; Wed, 27 Jun 2001 20:14:42 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:34059 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S265450AbRF1AO3>; Wed, 27 Jun 2001 20:14:29 -0400
Date: Wed, 27 Jun 2001 19:41:15 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: NIIBE Yutaka <gniibe@m17n.org>
Cc: "Stephen C. Tweedie" <sct@redhat.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] swapin flush cache bug
In-Reply-To: <200106280007.f5S07qQ04446@mule.m17n.org>
Message-ID: <Pine.LNX.4.21.0106271940440.1836-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 28 Jun 2001, NIIBE Yutaka wrote:

> Marcelo Tosatti wrote:
>  > I think Stephen C. Tweedie has some considerations about the cache
>  > flushing calls on do_swap_page().
> 
> Yup.  IIRC, he said that flushing cache at do_swap_page() (which I've
> tried at first) is not good, because it's the hot path and it causes
> another performance problem in apache or sendmail, where many
> processes share the pages in swap cache.

I guess he has some other comments about it... 

Again, Stephen ? 

