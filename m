Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272032AbRH2SEm>; Wed, 29 Aug 2001 14:04:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272036AbRH2SEc>; Wed, 29 Aug 2001 14:04:32 -0400
Received: from thebsh.namesys.com ([212.16.0.238]:13832 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S272032AbRH2SEU>; Wed, 29 Aug 2001 14:04:20 -0400
Message-ID: <3B8D2EB1.14B9C3A@namesys.com>
Date: Wed, 29 Aug 2001 22:04:33 +0400
From: Hans Reiser <reiser@namesys.com>
Organization: Namesys
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en, ru
MIME-Version: 1.0
To: Andreas Dilger <adilger@turbolabs.com>
CC: Roy Sigurd Karlsbakk <roy@karlsbakk.net>, linux-kernel@vger.kernel.org
Subject: Re: ext2 -> reiserfs conversion?
In-Reply-To: <Pine.LNX.4.30.0108291640540.4463-100000@mustard.heime.net> <20010829114126.G24270@turbolinux.com>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Dilger wrote:
> 
> On Aug 29, 2001  16:44 +0200, Roy Sigurd Karlsbakk wrote:
> > does any of you know if there are any plans to create an ext22reiserfs
> > utility?
> 
> It is probably more dangerous and difficult than it is worth.  Use a
> backup/restore, that way you also have a backup in case there is a
> problem with the conversion.
> 
> Since you would ALWAYS do a backup before performing such an operation
> (right????) then doing the restore to the newly formatted reiserfs
> partition would probably take less time than any kind of conversion
> would take (and be a LOT more robust, as well as doing a "defrag"),
> so you are way better off to do it that way.
> 
> Cheers, Andreas
> --
> Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
>                  \  would they cancel out, leaving him still hungry?"
> http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


Yes, it was the fear of a long debugging cycle that made me decide that tar over
VFS was the most reliable conversion method, and to not attempt to do more.  If
someone was to write a tar plus resize based script, that might be reliable, and
I would be interested to see it.

Hans
