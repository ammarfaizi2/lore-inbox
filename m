Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284305AbSAGSBS>; Mon, 7 Jan 2002 13:01:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284300AbSAGSBI>; Mon, 7 Jan 2002 13:01:08 -0500
Received: from [62.245.135.174] ([62.245.135.174]:49081 "EHLO mail.teraport.de")
	by vger.kernel.org with ESMTP id <S284305AbSAGSAz>;
	Mon, 7 Jan 2002 13:00:55 -0500
Message-ID: <3C39E24F.2BE8C62C@TeraPort.de>
Date: Mon, 07 Jan 2002 19:00:47 +0100
From: Martin Knoblauch <Martin.Knoblauch@TeraPort.de>
Reply-To: m.knoblauch@TeraPort.de
Organization: TeraPort GmbH
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.17 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Stephan von Krawczynski <skraw@ithnet.com>
CC: linux-kernel@vger.kernel.org, vanl@megsinet.net
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
In-Reply-To: <3C39DDC9.29F29E68@TeraPort.de> <20020107185506.0bfa4cfd.skraw@ithnet.com>
X-MIMETrack: Itemize by SMTP Server on lotus/Teraport/de(Release 5.0.7 |March 21, 2001) at
 01/07/2002 07:00:47 PM,
	Serialize by Router on lotus/Teraport/de(Release 5.0.7 |March 21, 2001) at
 01/07/2002 07:00:54 PM,
	Serialize complete at 01/07/2002 07:00:54 PM
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephan von Krawczynski wrote:
> 
> On Mon, 07 Jan 2002 18:41:29 +0100
> Martin Knoblauch <Martin.Knoblauch@TeraPort.de> wrote:
> 
> > Hi,
> >
> >  so I took the M.H.vL vmscan.c patch for 2.4.17 and it is a definite
> > winner for me. Sounds like 2.4.18 material.
> 
> What issues have been solved or remarkably become better for you with Martins
> patch?
> 
> Regards,
> Stephan

 massive reduction of swapped out applications in the light of a 220+
MiB Cache. This on a 320 MiB System with about 2x swap. As a result,
interactive behaviour (this is a notebook) is much better. Before the
patch I had about 50-60 MB in swap for my workload (vmware + netscape +
plus kernel compile + updatedb). Now it is below 5 MB, although this is
still to much (yes, I know, I could turn off swap completely :-)

 I also took the OOM-Killer patch, although it never was a real concern
for me.

Martin
-- 
------------------------------------------------------------------
Martin Knoblauch         |    email:  Martin.Knoblauch@TeraPort.de
TeraPort GmbH            |    Phone:  +49-89-510857-309
C+ITS                    |    Fax:    +49-89-510857-111
http://www.teraport.de   |    Mobile: +49-170-4904759
