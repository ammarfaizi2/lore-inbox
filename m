Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266377AbTAFJs6>; Mon, 6 Jan 2003 04:48:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266379AbTAFJs6>; Mon, 6 Jan 2003 04:48:58 -0500
Received: from 213-187-164-3.dd.nextgentel.com ([213.187.164.3]:11710 "EHLO
	mail.pronto.tv") by vger.kernel.org with ESMTP id <S266377AbTAFJsy> convert rfc822-to-8bit;
	Mon, 6 Jan 2003 04:48:54 -0500
Content-Type: text/plain;
  charset="iso-8859-15"
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Organization: ProntoTV AS
To: Wolfgang Fritz <wolfgang.fritz@gmx.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] (Was: i4l dtmf errors)
Date: Mon, 6 Jan 2003 10:57:23 +0100
User-Agent: KMail/1.4.1
References: <atg5jv$d73$1@fritz38552.news.dfncis.de> <Pine.LNX.4.44.0212141712410.7099-100000@chaos.physics.uiowa.edu> <atl3eq$s43$1@fritz38552.news.dfncis.de>
In-Reply-To: <atl3eq$s43$1@fritz38552.news.dfncis.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200301061057.23133.roy@karlsbakk.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi

thanks for the patch, but sorry - it really didn't help anything. still 
meep-meep's all over ...

roy

On Monday 16 December 2002 18:44, Wolfgang Fritz wrote:
> <veröffentlicht & per Mail versendet>
>
> Kai Germaschewski wrote:
> > On Sat, 14 Dec 2002, Wolfgang Fritz wrote:
> >> > it seems isdn4linux detects DTMF tones from normal speach. This is
> >> > rather annoying when using i4l for voice with Asterisk.org. This is
> >> > tested on all recent kernels
> >>
> >> The DTMF detection is broken since kernel 2.0.x. I have a patch for a
> >> 2.2 kernel which may manually be applied 2.4 kernels with some manual
> >> work. It fixes an overflow problem in the goertzel algorithm (which
> >> does the basic tone detection) and changes the algorithm to detect
> >> the DTMF pairs. If interested, I can try to recover that patch.
> >
> > If you dig out that patch and submit it (to me), I'm pretty sure
> > there's a good chance of it going into the official kernel. ISTR there
> > was talk about that earlier, but nothing ever happened.
> >
> > --Kai
>
> Here is the patch against 2.4.20.
>
> Wolfgang
>
> > -
> > To unsubscribe from this list: send the line "unsubscribe
> > linux-kernel" in the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/

-- 
Roy Sigurd Karlsbakk, Datavaktmester
ProntoTV AS - http://www.pronto.tv/
Tel: +47 9801 3356

Computers are like air conditioners.
They stop working when you open Windows.

