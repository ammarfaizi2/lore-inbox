Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312558AbSGJKAp>; Wed, 10 Jul 2002 06:00:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314584AbSGJKAo>; Wed, 10 Jul 2002 06:00:44 -0400
Received: from ppp3290-cwdsl.fr.cw.net ([62.210.105.37]:41097 "EHLO
	bouton.inet6-interne.fr") by vger.kernel.org with ESMTP
	id <S312558AbSGJKAn>; Wed, 10 Jul 2002 06:00:43 -0400
Date: Wed, 10 Jul 2002 12:03:23 +0200
From: Lionel Bouton <Lionel.Bouton@inet6.fr>
To: Bill Darrow <bdarrow@optonline.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: SIS645DX/SIS5513
Message-ID: <20020710120323.A2449@bouton.inet6-interne.fr>
Mail-Followup-To: Bill Darrow <bdarrow@optonline.net>,
	linux-kernel@vger.kernel.org
References: <20020709203746.49198f6a.bdarrow@optonline.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020709203746.49198f6a.bdarrow@optonline.net>; from bdarrow@optonline.net on mar, jui 09, 2002 at 08:37:46 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On mar, jui 09, 2002 at 08:37:46 -0400, Bill Darrow wrote:
> I recently aquired a motherboard with a SIS645DX northbridge and a SIS961B southbridge which has an IDE controller in the SIS5513 family...
> 
>     IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE] (rev 208).
> 
> There appears to be support for the SiS ide controllers in sis5513.c however there only appears to be support for the 645 and not the 645dx.  I can still use my IDE controller but device read timings on ATA133 harddrives show that they can only put out about 3M/sec which isn't acceptable.  Does anyone know of any support for the 645dx/5513 combo (961B)?  Or does anyone know a way I can make a quick hack on sis5513.c so that I can support my controller, even if its not to its fullest potential?
> 

You'll have to wait for me to find some time between work, relocation in
progress and friends
*OR*
make sure SiS management understand that not publishing specs in a wide
manner only hurt their sales. Save for one-liner patches, I've been the
only one able to contribute code to sis5513.c thanks to reverse-engineering
and specs/knowhow coming from anonymous sources for the last months.

To summarize current SiS position : if you want specs, you have to sign a
NDA.

I wanted to avoid the NDA and tried to explain that it won't be best for
Linux and SiS to have specs sent to few individuals and that the better
way was to make them available to the whole community.
This apparently was not an option and I finally agreed to sign the NDA...
to be told that the NDA was to be signed by a company -> no NDA, no official
spec for me.

As I am the last contributor to sis5513.c I am currently the only recipient
of "don't tell anyone I told you this" informations related to sis5513
derivatives.
This is a very unfortunate situation as I can't publish these informations
even if I don't have time to use them myself.

If someone has time to help me, I'll ask my anonymous sources if I can
privately forward you what I have. I would be glad to enter a more
cooperative development process but people willing to help must be aware of
the issues.

LB
