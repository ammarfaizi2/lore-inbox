Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286317AbRL0Pxb>; Thu, 27 Dec 2001 10:53:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286318AbRL0PxW>; Thu, 27 Dec 2001 10:53:22 -0500
Received: from falcon.mail.pas.earthlink.net ([207.217.120.74]:22226 "EHLO
	falcon.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S286317AbRL0PxI>; Thu, 27 Dec 2001 10:53:08 -0500
Message-ID: <3C2B43FD.6E2961E0@earthlink.net>
Date: Thu, 27 Dec 2001 10:53:33 -0500
From: Jeff <piercejhsd009@earthlink.net>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.16 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: nknight@pocketinet.com
CC: linux-kernel@vger.kernel.org
Subject: Re: Who fixed via82cxxx_audio.c ?
In-Reply-To: <WHITExvWvqzAoa2JB1n000005b3@white.pocketinet.com> <3C28A640.9C9B8462@loewe-komp.de>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nicholas,

Does the record work on your via82c686 sound? I have the same chip set
and I cannot get the record to work. Mixing and playing mp3's wav's etc
works ok. Mixing line-in/mic to line-out woeks fine.
Just cannot record.

I posted the probelm here and the only response I got was emails from a
couple of others with thee same propblem.

But, not one concerning fixing the problem. Or, if recording is even
implemented or not.

Using 2.4.16 kernel and via82cxxx_audio ver. 1.9.1

Peter Wächtler wrote:
> 
> Nicholas Knight schrieb:
> >
> > Several months back, I started trying to get the via82cxxx_audio.c
> > sound driver fixed, it was causing lockup problems whenever something
> > opened and/or used the mixer. A similar route was taken as I took with
> > the Athlon optimization problems, trying to get everyone to send as
> > much information as possible on their cards using this driver. This
> > never really led anywhere, and the only information gleaned was that
> > dropping buffers down to extremely low levels helped in some cases, but
> > not all, and didn't always completely fix it.
> >
> > After 2.4.10 was released, I stopped updating my kernel for a variety
> > of reasons (less time spent in linux, long story.) However a while back
> > I updated to 2.4.16, and decided to load XMMS just for the hell of it,
> > not 5 minutes ago. To my delight, the problem is completely solved. I
> > checked all the changelogs from 2.4.10 to now, and the only mention I
> > found searching for "97" (ac97 codec is used) and "via82" was in the
> > 2.4.*17* changelog, saying Jeff was no longer the maintainer.
> > I'd like to know who managed to find and fix the underlying cause, so I
> > can both thank them, and find out what the heck this problem that
> > plagued me for many months was.
> 
> I would check the ChangeLog of the audio driver, since the
> hardware access to the ac97 mixer is done there.
> 
> --
> ciao
> Peter
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

Jeff
piercejhsd009@earthlink.net
