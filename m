Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265541AbSJXQiU>; Thu, 24 Oct 2002 12:38:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265542AbSJXQiU>; Thu, 24 Oct 2002 12:38:20 -0400
Received: from warden-p.diginsite.com ([208.29.163.248]:41884 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id <S265541AbSJXQiS>; Thu, 24 Oct 2002 12:38:18 -0400
From: David Lang <david.lang@digitalinsight.com>
To: "Henning P. Schmiedehausen" <hps@intermeta.de>
Cc: linux-kernel@vger.kernel.org
Date: Thu, 24 Oct 2002 09:34:51 -0700 (PDT)
Subject: Re: One for the Security Guru's
In-Reply-To: <ap97nr$h6e$1@forge.intermeta.de>
Message-ID: <Pine.LNX.4.44.0210240933080.18594-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Unfortunantly there are things that you can't do with a network based SSL
accelerator box (specificly have your webserver give people an
understandable warning if they are useing weak encryption) so this isn't
the Right (tm) way of doing things, it's one of the ways to do them.

David Lang

On Thu, 24 Oct 2002, Henning P. Schmiedehausen wrote:

> Date: Thu, 24 Oct 2002 16:39:23 +0000 (UTC)
> From: Henning P. Schmiedehausen <hps@intermeta.de>
> To: linux-kernel@vger.kernel.org
> Newsgroups: hometree.linux.kernel
> Subject: Re: One for the Security Guru's
>
> Gerhard Mack <gmack@innerfire.net> writes:
>
> >It gets even worse if almost all of your services are encrypted(like you
> >would find on an e-commerse site).  https will blind an IDS.  The last
> >place I worked only had 3 ports open and 2 of them were encrypted.
>
> Nah. Do it right:
>
> Internet ----- Firewall ---- SSL Accelerator Box --+---- Webserver
>          HTTPS          HTTPS                      | HTTP
>                                                    |
>                                                   IDS
>
> Check out the boxes from SonicWall, they're quite nice. Expensive,
> though. If your E-Commerce site can't afford them, well, then they
> shouldn't be able to affore a security consulant in the first
> place. :-)
>
> 	Regards
> 		Henning
> --
> Dipl.-Inf. (Univ.) Henning P. Schmiedehausen       -- Geschaeftsfuehrer
> INTERMETA - Gesellschaft fuer Mehrwertdienste mbH     hps@intermeta.de
>
> Am Schwabachgrund 22  Fon.: 09131 / 50654-0   info@intermeta.de
> D-91054 Buckenhof     Fax.: 09131 / 50654-20
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
