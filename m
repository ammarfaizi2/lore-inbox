Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316222AbSEKOT3>; Sat, 11 May 2002 10:19:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316223AbSEKOT3>; Sat, 11 May 2002 10:19:29 -0400
Received: from [62.70.58.70] ([62.70.58.70]:30795 "EHLO mail.pronto.tv")
	by vger.kernel.org with ESMTP id <S316222AbSEKOT2> convert rfc822-to-8bit;
	Sat, 11 May 2002 10:19:28 -0400
Message-Id: <200205111418.g4BEIa629620@mail.pronto.tv>
Content-Type: text/plain; charset=US-ASCII
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Organization: Pronto TV AS
To: Linus Torvalds <torvalds@transmeta.com>, Lincoln Dale <ltd@cisco.com>
Subject: Re: O_DIRECT performance impact on 2.4.18 (was: Re: [PATCH] 2.5.14  IDE 56)
Date: Sat, 11 May 2002 16:18:35 +0200
X-Mailer: KMail [version 1.3.1]
Cc: Andrew Morton <akpm@zip.com.au>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Martin Dalecki <dalecki@evision-ventures.com>,
        Padraig Brady <padraig@antefacto.com>,
        Anton Altaparmakov <aia21@cantab.net>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0205100854370.2230-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 10 May 2002 17:55, Linus Torvalds wrote:
> On Fri, 10 May 2002, Lincoln Dale wrote:
> > so O_DIRECT in 2.4.18 still shows up as a 55% performance hit versus no
> > O_DIRECT. anyone have any clues?
>
> Yes.
>
> O_DIRECT isn't doing any read-ahead.
>
> For O_DIRECT to be a win, you need to make it asynchronous.

Will the use of O_DIRECT affect disk elevatoring?

Sorry if this is OT - I just need to know

Please cc: to me as I'm not on the list

roy
