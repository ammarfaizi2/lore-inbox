Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314106AbSEXNP5>; Fri, 24 May 2002 09:15:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314351AbSEXNP4>; Fri, 24 May 2002 09:15:56 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:29361 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S314106AbSEXNP4>;
	Fri, 24 May 2002 09:15:56 -0400
Date: Fri, 24 May 2002 15:15:36 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: Vojtech Pavlik <vojtech@suse.cz>, Oleg Drokin <green@namesys.com>,
        "Gryaznova E." <grev@namesys.botik.ru>, martin@dalecki.de,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Reiserfs developers mail-list <Reiserfs-Dev@namesys.com>
Subject: Re: [reiserfs-dev] Re: IDE problem: linux-2.5.17
Message-ID: <20020524151536.C636@ucw.cz>
In-Reply-To: <3CECF59B.D471F505@namesys.botik.ru> <3CECFC5B.3030701@evision-ventures.com> <20020523193959.A2613@namesys.com> <3CED004A.6000109@evision-ventures.com> <20020524005057.F27005@ucw.cz> <3CEE1DFE.4080500@evision-ventures.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 24, 2002 at 01:03:26PM +0200, Martin Dalecki wrote:
> U¿ytkownik Vojtech Pavlik napisa³:
> 
> > 
> >>Hmm thinking again about it... It occurrs to me
> >>that actually there should be a mechanism which tells the
> >>host chip drivers whatever there are only just one or
> >>two drivers connected. I will have to look in to it.
> > 
> > 
> > There is no such mechanism (except for probing the drives). IDE has
> > quite nonsensical "split" termination - the termination resistors are
> > always present even on the middle device. This is to "simplify" things
> > ...
> > 
> 
> Yes there is the host chip timer setting is basically
> changing the termination properties on the hsot chips part
> of the connection. This is the reason I was thinking
> that making the driver for it know how many drivers
> are attached to it could make some sense.

Hmm, interesting. Is it on all chips or just some? I don't know about
anything like that on Intel, VIA, nVidia, AMD, SiS and Artop controllers ...

-- 
Vojtech Pavlik
SuSE Labs
