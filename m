Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130287AbQLKUVt>; Mon, 11 Dec 2000 15:21:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130307AbQLKUVj>; Mon, 11 Dec 2000 15:21:39 -0500
Received: from aragorn.ics.muni.cz ([147.251.4.33]:30927 "EHLO
	aragorn.ics.muni.cz") by vger.kernel.org with ESMTP
	id <S130287AbQLKUVa>; Mon, 11 Dec 2000 15:21:30 -0500
Newsgroups: cz.muni.redir.linux-kernel
Path: news
From: Zdenek Kabelac <kabi@fi.muni.cz>
Subject: Re: UP 2.2.18 makes kernels 3% faster than UP 2.4.0-test12
Message-ID: <3A353022.81E7BC5E@fi.muni.cz>
Date: Mon, 11 Dec 2000 19:50:58 GMT
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
X-Nntp-Posting-Host: dual.fi.muni.cz
Content-Transfer-Encoding: 7bit
X-Accept-Language: Czech, en
Content-Type: text/plain; charset=iso-8859-2
In-Reply-To: <E145Xy6-0008HA-00@the-village.bc.nu>
Mime-Version: 1.0
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test12 i686)
Organization: unknown
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > Doing a 'make bzImage' is NOT VM-intensive. Using this as a test
> > for the VM doesn't make any sense since it doesn't really excercise
> > the VM in any way...
> 
> Its an interesting demo that 2.4 has some performance problems since 2.2
> is slower than 2.0 although nowdays not much.

Speaking about performance - could someone explain me why
md5checksumming on 10GB
partition is taking my whole 128MB memory and is permamently swaping out
every application off my memory to swap so the computer is very slow
during
this process???

Could I set somewhere in /proc that I do not wish to have 100MB disk
buffers ?


-- 
  Zdenek Kabelac  http://i.am/kabi/ kabi@i.am {debian.org; fi.muni.cz}

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
