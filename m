Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273615AbRIYVIe>; Tue, 25 Sep 2001 17:08:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273617AbRIYVIY>; Tue, 25 Sep 2001 17:08:24 -0400
Received: from adsl-196-233.cybernet.ch ([212.90.196.233]:13062 "HELO
	mailphish.drugphish.ch") by vger.kernel.org with SMTP
	id <S273615AbRIYVIP>; Tue, 25 Sep 2001 17:08:15 -0400
Message-ID: <3BB0F297.D4A9E986@drugphish.ch>
Date: Tue, 25 Sep 2001 23:09:43 +0200
From: Roberto Nibali <ratz@drugphish.ch>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
Cc: Mark Zealey <mark@itsolve.co.uk>, linux-kernel@vger.kernel.org
Subject: Re: Binary only module overview
In-Reply-To: <20010924124044.B17377@devserv.devel.redhat.com> <20010925084439.B6396@us.ibm.com> <20010925200947.B7174@itsolve.co.uk> <20010925134232.A14715@kroah.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

> > > Argus System's PitBull for Linux modifies the kernel.  No source or
> > > patches for these modifications can be found on the web, so I'm guessing
> > > that it's closed source:
> > >     http://www.argus-systems.com/
> >
> > Umm, is it me or is that totally against the GPL? Have you bitched at them about
> > this?
> 
> I have only talked to one of their resellers, who could not find a link
> to the code anywhere.  I have not asked them directly.  I will go do
> that right now.

If you're dealing with argus, ask straight for developers or technical
people not resellers. The second problem is that they ceased making
their
Pitbull LX product available for download on the web for some reasons.
Since I work with argus-system products sometime I got the chance of
still
having a copy of this huge tarball and I made a diff or their actual
changes
to the 2.2.19 kernel for you. Unfortunately I had to put it onto a non-
argus related development site and I will leave it there for the next 12 
hours. Grab it, analyse it and convince yourself that they actually go
quite into the direction of the LSM framework approach. Actually I
talked
to one of the argus technical guys about a possible port to the LSM
frame-
work and he said that they are going to look into it. Of course the lkm
with the real security functionality is binary only. Decide yourself ...

http://www.linuxvirtualserver.org/~ratz/argus.diff

Best regards,
Roberto Nibali, ratz
