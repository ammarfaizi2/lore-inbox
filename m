Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316906AbSFFNJL>; Thu, 6 Jun 2002 09:09:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316919AbSFFNJK>; Thu, 6 Jun 2002 09:09:10 -0400
Received: from mail.parknet.co.jp ([210.134.213.6]:28172 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP
	id <S316906AbSFFNJJ>; Thu, 6 Jun 2002 09:09:09 -0400
To: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] remove the fat_cvf
In-Reply-To: <73BA70C46BF@vcnet.vc.cvut.cz>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Thu, 06 Jun 2002 22:08:44 +0900
Message-ID: <87wutc4krn.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Petr Vandrovec" <VANDROVE@vc.cvut.cz> writes:

> On  6 Jun 02 at 0:31, OGAWA Hirofumi wrote:
> > This patch is first stuff to remove fat_cvf. AFAIK, it seems the
> > fat_cvf isn't used for a long time. And fat_cvf makes change of fatfs
> > difficult.
> > 
> > Is the fat_cvf needed? If it's not needed, I will submit the
> > following patch at this weekend..
> 
> ftp://fb9nt.uni-duisburg.de/pub/linux/dmsdos/README reads:
> --
> PLEASE NOTE:
> 
>  The DMSDOS project is dead. I no longer maintain it due to lack of time.
>  The latest supported kernel is 2.2.15 with dmsdos 0.9.2.1.
>  There will never be a kernel 2.4.x port. Dmsdos 0.9.2.3-pre2 was an
>  attempt to port the code, but it has failed. Don't use it.
> --        
> and it is latest dmsdos related file I found (and 0.9.2.1 is latest
> I used on 2.2.17), so I believe that it is safe to remove cvf code
> from fatfs. Both Stacker and Doublespace supported FAT16 only, so
> current usual 120GB disk would require 120 logical units with estimated
> compression ratio 2:1. IMHO adding dmsdosfs into mtools is the best 
> solution for those who still need it.

Indeed. If dmsdos is need, I think it must rewriting already many
stuff.  Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
