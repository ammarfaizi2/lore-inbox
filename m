Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265589AbTAPI52>; Thu, 16 Jan 2003 03:57:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265633AbTAPI51>; Thu, 16 Jan 2003 03:57:27 -0500
Received: from ns.indranet.co.nz ([210.54.239.210]:59613 "EHLO
	mail.acheron.indranet.co.nz") by vger.kernel.org with ESMTP
	id <S265589AbTAPI51>; Thu, 16 Jan 2003 03:57:27 -0500
Date: Thu, 16 Jan 2003 22:01:25 +1300
From: Andrew McGregor <andrew@indranet.co.nz>
To: Ferry van Steen <freaky@www.bananateam.nl>, linux-kernel@vger.kernel.org
Subject: Re: Partially closed source module, more of gcc/ld question.
Message-ID: <28230000.1042707685@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.33.0301160825140.6306-100000@www.bananateam.nl>
References: <Pine.LNX.4.33.0301160825140.6306-100000@www.bananateam.nl>
X-Mailer: Mulberry/3.0.0b10 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Check out the patches for the NVIDIA driver on www.minion.de, there's a 
linker hack in the most recent patch which fixes this.

Andrew

--On Thursday, January 16, 2003 08:29:31 +0100 Ferry van Steen 
<freaky@www.bananateam.nl> wrote:

> Hey there,
>
> some of you might have read my message on the promise fasttrak last time.
> I'm sorry to say that I started yelling to them through e-mail and the
> replied now! This is the so manied company that suddenly replies if you
> yell... Oh well, they released some new module, which I want to try later
> on.
>
> Sortta like nvidia, you get a Makefile, some others an object and 3 C
> files. Now for the question. Loading a gcc v2 compiled module into a v3
> compiled kernel causes problems. Is it correct to assume then that if the
> object were compiled with v2, and the C files with v3 and those get linked
> together into a module, that you might experience the same problems?
>
> Is there any way I can see with which version the object was compiled
> (the kernel seems to be able to, or atleast, partially it doesn't give
> specific version just v2 or v3)?
>
> Kind regards
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
>


