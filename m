Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932241AbWBFRRj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932241AbWBFRRj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 12:17:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932242AbWBFRRi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 12:17:38 -0500
Received: from mx01.qsc.de ([213.148.129.14]:64735 "EHLO mx01.qsc.de")
	by vger.kernel.org with ESMTP id S932241AbWBFRRi convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 12:17:38 -0500
From: =?iso-8859-1?q?Ren=E9_Rebe?= <rene@exactcode.de>
Organization: ExactCODE
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Subject: Re: CD writing in future Linux try #2 [ was: Re: CD writing in future Linux (stirring up a hornets' nest) ]
Date: Mon, 6 Feb 2006 18:17:11 +0100
User-Agent: KMail/1.9
Cc: jengelh@linux01.gwdg.de, mrmacman_g4@mac.com, matthias.andree@gmx.de,
       linux-kernel@vger.kernel.org, bzolnier@gmail.com, acahalan@gmail.com
References: <58cb370e0601270837h61ac2b03uee84c0fa9a92bc28@mail.gmail.com> <Pine.LNX.4.61.0602051300430.11476@yvahk01.tjqt.qr> <43E7795D.nail81Y3TBMUC@burner>
In-Reply-To: <43E7795D.nail81Y3TBMUC@burner>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200602061817.11240.rene@exactcode.de>
X-Spam-Score: -1.4 (-)
X-Spam-Report: Spam detection software, running on the system "grum.localhost", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Hi, On Monday 06 February 2006 17:29, Joerg Schilling
	wrote: > Jan Engelhardt <jengelh@linux01.gwdg.de> wrote: > > > I just
	found that the followig "works" (cdrom drive not supported, but > >
	other than that seems fine) under Solaris 11 snv_30 x86, much to my > >
	surprise: > > > > cdrecord -dev=/dev/rdsk/c1t0d0p0 -toc > > > > which
	worked just as well as > > > > cdrecord -dev=1,0,0 -toc > > > > I would
	have rather expected to get > > > > Warning: Open by 'devname' is
	unintentional and not supported. > > You are the first to try this
	unsupported dev parameter. > > Fortunately, users on Solaris usually
	read the man pages before > doing wrong things and then it usually
	works.... > > Once I see to many people using this kind of CLI, I'll add
	a note. [...] 
	Content analysis details:   (-1.4 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-1.4 ALL_TRUSTED            Passed through trusted hosts only via SMTP
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Monday 06 February 2006 17:29, Joerg Schilling wrote:
> Jan Engelhardt <jengelh@linux01.gwdg.de> wrote:
> 
> > I just found that the followig "works" (cdrom drive not supported, but 
> > other than that seems fine) under Solaris 11 snv_30 x86, much to my 
> > surprise:
> >
> >   cdrecord -dev=/dev/rdsk/c1t0d0p0 -toc
> >
> > which worked just as well as
> >
> >   cdrecord -dev=1,0,0 -toc
> >
> > I would have rather expected to get
> >
> >   Warning: Open by 'devname' is unintentional and not supported.
> 
> You are the first to try this unsupported dev parameter.
> 
> Fortunately, users on Solaris usually read the man pages before
> doing wrong things and then it usually works....
> 
> Once I see to many people using this kind of CLI, I'll add a note.

If I would not be in Berlin as well I would ask what good drugs there are to
smoke - heck - wait - there *is* over average drug dealing going along here ...

You still never ever explained *why* you think specifing devices by name
is so bad ...

Have you patched your schillix mount, fsck.* and co to take a pseudo
SCSI ID as well?

Start to get that _the_ interface to devices on Unix and a-like systems
are device nodes in /dev (or simillar) - not artificially made up IDs the
user has to find out for the system (or add -scanbus (or what it was)
to any program executed).

Still if _you_ do not like that, 99.999% of the Linux users and developers
_do_. So stop whining about it.

PS: Yes, I run a bastarized version of cdrecord that has a whole bunch of
crap patched away.

Have fun,

-- 
René Rebe - Rubensstr. 64 - 12157 Berlin (Europe / Germany)
            http://www.exactcode.de | http://www.t2-project.org
            +49 (0)30  255 897 45
