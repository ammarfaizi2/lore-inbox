Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313132AbSD3IgS>; Tue, 30 Apr 2002 04:36:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313137AbSD3IgR>; Tue, 30 Apr 2002 04:36:17 -0400
Received: from [62.245.135.174] ([62.245.135.174]:51114 "EHLO mail.teraport.de")
	by vger.kernel.org with ESMTP id <S313132AbSD3IgR> convert rfc822-to-8bit;
	Tue, 30 Apr 2002 04:36:17 -0400
Message-ID: <3CCE577A.DD3D83FE@TeraPort.de>
Date: Tue, 30 Apr 2002 10:36:10 +0200
From: Martin Knoblauch <Martin.Knoblauch@TeraPort.de>
Reply-To: m.knoblauch@TeraPort.de
Organization: TeraPort GmbH
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre5-ac3 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: pashley@storm.ca,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: The tainted message
X-MIMETrack: Itemize by SMTP Server on lotus/Teraport/de(Release 5.0.7 |March 21, 2001) at
 04/30/2002 10:36:09 AM,
	Serialize by Router on lotus/Teraport/de(Release 5.0.7 |March 21, 2001) at
 04/30/2002 10:36:16 AM,
	Serialize complete at 04/30/2002 10:36:16 AM
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=iso-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Re: The tainted message
> 
> 
> Christian Bornträger wrote:
> >
> > Ian Molton wrote:
> > > Warning: Module %s is not open source, and as such, loading it will make
> > > your kernel un-debuggable. Please do not submit bug reports from a kernel
> > > with this module loaded, as they will be useless, and likely ignored.
> 
> Warning: Source code for module %s is not publicly available. Problems
> with a kernel that has loaded this module can be debugged only by someone
> with access to the module source. Therefore, please submit any bug reports
> to the module supplier, not to the Linux kernel mailing list.
> -

 The one on top is IMHO better. The reason is that the wording of the
second one, although giving better explanation why it (may) make the
kernel undebuggable, implicitely suggests (to me as a nonative english
speaker) that the problem is caused by the non compatibly licensed
module. Which I venture is not true in a lot of cases.

 Also, in both messages it is stated that the source is not publicly
available. This is not obvious to me. The module may just lack an
explicitely stated license. Maybe just a case of not RTFMing the modules
documentation, or an old source that hasn't been touched since
introduction of the tainting stuff.

 So, I would prefer:

"Warning: Source code for module %s may not be publicly available.
Problems
with a kernel that has loaded this module can be debugged only by
someone
with access to the module source. Therefore, please do not submit any
bug
reports to the Linux kernel mailing list unless you can reproduce them
without having this module loaded."

 As for using the term "tainted" in the warning: I do not like it,
because it has a absolutely negative meaning if translated into German
and maybe (likely?) other languanges. This could give the impression
that the warning tries to tell the user that non-compatibly licensed
modules are [the source of all] evil. Some of them may be evil, but I do
not buy this concept in general.

Martin
--
------------------------------------------------------------------
Martin Knoblauch         |    email:  Martin.Knoblauch@TeraPort.de
TeraPort GmbH            |    Phone:  +49-89-510857-309
C+ITS                    |    Fax:    +49-89-510857-111
http://www.teraport.de   |    Mobile: +49-170-4904759
