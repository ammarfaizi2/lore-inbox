Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263384AbREXGGj>; Thu, 24 May 2001 02:06:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263385AbREXGGa>; Thu, 24 May 2001 02:06:30 -0400
Received: from idiom.com ([216.240.32.1]:44305 "EHLO idiom.com")
	by vger.kernel.org with ESMTP id <S263384AbREXGGO>;
	Thu, 24 May 2001 02:06:14 -0400
Message-ID: <3B0CA428.82447AA2@namesys.com>
Date: Wed, 23 May 2001 23:03:20 -0700
From: Hans Reiser <reiser@namesys.com>
Organization: Namesys
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en, ru
MIME-Version: 1.0
To: monkeyiq <monkeyiq@users.sourceforge.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: Dying disk and filesystem choice.
In-Reply-To: <m3bsoj2zsw.fsf@kloof.cr.au>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

monkeyiq wrote:
> 
> Hi,
>   Could I please be CC'd replies.
> 
>   To keep it short and sweet, I have a 45Gb IBM drive that
> is slowly dying by getting more bad sectors. I have already
> returned my first one to get the current disk, so would like
> to use the current one for a while before returning it for
> another disk that will prolly just start dying again.
> 
> I am using reiserfs at the moment, which doesn't really like
> to work on a dying drive. for example, doing a make fails to
> work even though it is *creating* files on the disk, it fails
> to do so because it hits new bad sectors and doesn't seem to
> remap them.
> 
> I am wondering what advise on filesystem choice the list as
> and any other options I can use to get the kernel to remap
> bad blocks.
> 
> Thanks.
> 
> --
> ---------------------------------------------------
> It's the question, http://witme.sourceforge.net
> If you think education is expensive, try ignorance.
>                 -- Derek Bok, president of Harvard
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

You can get the badblocks patch from Nikita and continue using reiserfs if you
want.  ext2 will also work.

We haven't sent the badblocks patch to Linus solely because it is a feature not
a bugfix, and code-freeze is on.

Hans
