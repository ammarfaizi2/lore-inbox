Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315198AbSDWNgc>; Tue, 23 Apr 2002 09:36:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315202AbSDWNgb>; Tue, 23 Apr 2002 09:36:31 -0400
Received: from [62.245.135.174] ([62.245.135.174]:38057 "EHLO mail.teraport.de")
	by vger.kernel.org with ESMTP id <S315198AbSDWNg3>;
	Tue, 23 Apr 2002 09:36:29 -0400
Message-ID: <3CC56355.E5086E46@TeraPort.de>
Date: Tue, 23 Apr 2002 15:36:21 +0200
From: Martin Knoblauch <Martin.Knoblauch@TeraPort.de>
Reply-To: m.knoblauch@TeraPort.de
Organization: TeraPort GmbH
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre5-ac3 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: kernel@Expansa.sns.it
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: XFS in the main kernel
X-MIMETrack: Itemize by SMTP Server on lotus/Teraport/de(Release 5.0.7 |March 21, 2001) at
 04/23/2002 03:36:21 PM,
	Serialize by Router on lotus/Teraport/de(Release 5.0.7 |March 21, 2001) at
 04/23/2002 03:36:29 PM,
	Serialize complete at 04/23/2002 03:36:29 PM
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Re: XFS in the main kernel
> 
> From: Luigi Genoni (kernel@Expansa.sns.it)
> On Tue, 23 Apr 2002, Keith Owens wrote:
> 
> > On 22 Apr 2002 18:55:20 +0200,
> > wichert@cistron.nl (Wichert Akkerman) wrote:
> > >In article <3CC427F4.12C40426@fnal.gov>,
> > >Dan Yocum <yocum@fnal.gov> wrote:
> > >>I know it's been discussed to death, but I am making a formal request to you
> > >>to include XFS in the main kernel. We (The Sloan Digital Sky Survey) and
> > >>many, many other groups here at Fermilab would be very happy to have this in
> > >>the main tree.
> > >
> > >Has XFS been proven to be completely stable
> >
> > As much as any other filesystem. "There are no bugs in filesystem XYZ.
> > That just means that you have not looked hard enough." :) There is a
> > daily QA suite that XFS is run through.
> 
> In the reality the inclusion on XFS in the 2.5 tree would probably move
> more peole to use it, and so also to eventually trigger bugs, to report
> them, sometimes to fix them.
> This way XFS would improve faster, and of course that would be a
> good thing.
>

 definitely. Unless XFS is in the mainline kernel (marked as
experimantal if necessary) it will not get good exposure.

 The most important (only) reason I do not use it (and recommend our
customers against using it) is that at the moment it is impossible to
track both the kernel and XFS at the same time. This is a shame, because
I think that for some application XFS is superior to the other
alternatives (can be said about the other alternatives to :-).
 
> That said, it is important to
> consider the technical reasons to include XFS in 2.5 or not; if this
> inclusion could cause some troubles, if XFS fits the requirements
> Linus asks for the inclusion and what impact the inclusion would have on
> the kernel (Think to JFS as a good example of an easy inclusion, with low
> impact).
> 

 so, what were the main obstacles again? The VFS layer?

Martin
-- 
------------------------------------------------------------------
Martin Knoblauch         |    email:  Martin.Knoblauch@TeraPort.de
TeraPort GmbH            |    Phone:  +49-89-510857-309
C+ITS                    |    Fax:    +49-89-510857-111
http://www.teraport.de   |    Mobile: +49-170-4904759
