Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292336AbSB0LHi>; Wed, 27 Feb 2002 06:07:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292329AbSB0LHZ>; Wed, 27 Feb 2002 06:07:25 -0500
Received: from [62.245.135.174] ([62.245.135.174]:8583 "EHLO mail.teraport.de")
	by vger.kernel.org with ESMTP id <S289299AbSB0LGr>;
	Wed, 27 Feb 2002 06:06:47 -0500
Message-ID: <3C7CBDC0.9F9CDBAC@TeraPort.de>
Date: Wed, 27 Feb 2002 12:06:40 +0100
From: Martin Knoblauch <Martin.Knoblauch@TeraPort.de>
Reply-To: m.knoblauch@TeraPort.de
Organization: TeraPort GmbH
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.18-ac1-K3-preempt-lockbr-stats-stuff-lowlat i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Rik van Riel <riel@conectiva.com.br>
CC: Martin.Bligh@us.ibm.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.19-preX: What we really need: -AA patches finally in thetree
In-Reply-To: <Pine.LNX.4.33L.0202270800420.7820-100000@imladris.surriel.com>
X-MIMETrack: Itemize by SMTP Server on lotus/Teraport/de(Release 5.0.7 |March 21, 2001) at
 02/27/2002 12:06:40 PM,
	Serialize by Router on lotus/Teraport/de(Release 5.0.7 |March 21, 2001) at
 02/27/2002 12:06:47 PM,
	Serialize complete at 02/27/2002 12:06:47 PM
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:
> 
> On Wed, 27 Feb 2002, Martin Knoblauch wrote:
> 
> > > > Not to begin the flamewar, but no thanks. rmap-12f blows -aa away AFAIK
> > > > on this P200 w/ 64MB ram.
> > >
> > > rmap still sucks on large systems though. I'd love to see rmap
> > > in the main kernel, but it needs to get the scalability fixed first.
> > > The main problem seems to be pagemap_lru_lock ... Rik & crew
> > > know about this problem, but let's give them some time to fix it
> > > before rmap gets put into mainline ....
> >
> >  just out of curiosity: where does "large systems" start in your
> > context?
> 
> My guess it would start at about 4 or 8 CPUs.
> 
> Systems which have a lot of pagetable overhead would also
> suffer with -rmap, until -rmap supports pte_highmem.
> 

 So, what about a Dual-Athlon system with 2-3 GB of memory? Large
system, or just a peanut? :-)

Martin
-- 
------------------------------------------------------------------
Martin Knoblauch         |    email:  Martin.Knoblauch@TeraPort.de
TeraPort GmbH            |    Phone:  +49-89-510857-309
C+ITS                    |    Fax:    +49-89-510857-111
http://www.teraport.de   |    Mobile: +49-170-4904759
