Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265862AbRF2Lcs>; Fri, 29 Jun 2001 07:32:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265865AbRF2Lci>; Fri, 29 Jun 2001 07:32:38 -0400
Received: from [194.102.102.3] ([194.102.102.3]:8975 "HELO ns1.Aniela.EU.ORG")
	by vger.kernel.org with SMTP id <S265862AbRF2LcX>;
	Fri, 29 Jun 2001 07:32:23 -0400
Date: Fri, 29 Jun 2001 14:34:20 +0300 (EEST)
From: lk <lk@ns1.Aniela.EU.ORG>
To: Edmund GRIMLEY EVANS <edmundo@rano.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: directory order of files
In-Reply-To: <20010629101818.A13817@rano.org>
Message-ID: <Pine.LNX.4.30.0106291433470.8258-100000@ns1.Aniela.EU.ORG>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


on reiserfs ls -U show soething like:

one two four three





On Fri, 29 Jun 2001, Edmund GRIMLEY EVANS wrote:

> With Linux ext2, and some other systems, when you create files in a
> new directory, the file system remembers their order:
>
> $ mkdir new
> $ cd new
> $ touch one two three four
> $ ls -U
> one  two  three  four
>
> (1) Is there any standard that says a system should behave this way?
> Is there any software that depends on this behaviour?
>
> (2) Are there Linux file systems that don't work this way? Maybe
> someone with a mounted writable reiserfs could do a quick check.
>
> Please copy replies to me as I am not subscribed. Thanks.
>
> Edmund
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

