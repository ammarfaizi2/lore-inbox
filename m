Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278739AbRJZQgL>; Fri, 26 Oct 2001 12:36:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278756AbRJZQgC>; Fri, 26 Oct 2001 12:36:02 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:42514 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S278755AbRJZQfw>; Fri, 26 Oct 2001 12:35:52 -0400
To: linux-kernel@vger.kernel.org
From: hpa@transmeta.com (H. Peter Anvin)
Subject: Re: PATCH 2.4.14.2: more inflate_fs build fixes
Date: 26 Oct 2001 09:35:31 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9rc3cj$pt$1@tazenda.transmeta.com>
In-Reply-To: <3BD92F59.BAD76B6F@mandrakesoft.com> <E15x7tg-0000Df-00@the-village.bc.nu>
Reply-To: hpa@transmeta.com (H. Peter Anvin)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <E15x7tg-0000Df-00@the-village.bc.nu>
By author:    Alan Cox <alan@lxorguk.ukuu.org.uk>
In newsgroup: linux.dev.kernel
>
> > This is required also, in order to build cramfs or zisofs in
> > 2.4.14-pre2.
> 
> I was going to send Linus that too after I grabbed pre2 - thanks.
> 
> Alan
> 

Also, grab_cache_page_nowait() [mm/filemap.c] is missing in -pre2, so
zisofs still won't build without it.  I will look at the new mm code
and try to determine how applicable the code I have is; if not, I
might end up having to contact Andrea for some tips.

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
