Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265725AbSKAUHA>; Fri, 1 Nov 2002 15:07:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265728AbSKAUHA>; Fri, 1 Nov 2002 15:07:00 -0500
Received: from c-66-176-164-150.se.client2.attbi.com ([66.176.164.150]:64741
	"EHLO schizo.psychosis.com") by vger.kernel.org with ESMTP
	id <S265725AbSKAUG6>; Fri, 1 Nov 2002 15:06:58 -0500
Content-Type: text/plain; charset=US-ASCII
From: Dave Cinege <dcinege@psychosis.com>
Reply-To: dcinege@psychosis.com
To: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] Initrd Dynamic -- Initramfs's GrandDaddy...(and competition)
Date: Fri, 1 Nov 2002 15:13:21 -0500
User-Agent: KMail/1.4.2
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>,
       Alan Cox <alan@www.linux.org.uk>
References: <200211010605.12473.dcinege@psychosis.com> <3DC26333.4040006@pobox.com>
In-Reply-To: <3DC26333.4040006@pobox.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200211011513.21582.dcinege@psychosis.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 01 November 2002 6:19, Jeff Garzik wrote:

> >What initramfs has that this doesn't:
> >	Load image from a 'linked' kernel location.
> >	Uses CPIO archives
>
> early userspace, which is the whole point of the exercise.
>
> We want to move a bunch of stuff _out_ of the kernel to userspace.

WHEN THAT DAY COMES....this will cleanly support it. 

Infact it supports it now...just not from a 'linked' archive.
(We'll see if I can change that tonight)

Right now 'early userspace' is a concept not a codeset.
(Unless someone is hiding it from me...I did ask you where
it is...) There is no standardized archive that goes there.
Until it is developed the current initramfs code does nothing
but eat kernel space.

Unlike the current initramfs solution this code provides a
smooth transitional base that can CLEANLY be merged back into the
2.4.xx branch. In a few minutes I can make an #ifdef of the
legacy floppy/block loading code. (Infact I think I'll do
just that, and submit an update. Until I hear 'no' from Linus,
I'm going to punish myself and proceed forward.) 

I'm sitting on the idea 'past performance will yeild similar
present results'. *14 months* ago I tried to get Initrd Dynamic
into the 2.4 kernel.

I was told last YEAR 'There is no point. Initramfs is coming.'

Unlike last year the version I'm submitting now is a crystal clean
merge.

Like last YEAR I'm told 'There is no point. Initramfs is coming.'

Well there is a point:
	Initrd Dynamic does the job better and it's working now!

Dave

-- 
The time is now 22:48 (Totalitarian)  -  http://www.ccops.org/

