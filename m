Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317165AbSEXPOh>; Fri, 24 May 2002 11:14:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317166AbSEXPOg>; Fri, 24 May 2002 11:14:36 -0400
Received: from DHCP-89-51.SLAC.Stanford.EDU ([134.79.89.51]:59276 "EHLO
	router-273.sgowdy.org") by vger.kernel.org with ESMTP
	id <S317165AbSEXPOc>; Fri, 24 May 2002 11:14:32 -0400
Date: Fri, 24 May 2002 08:13:58 -0700 (PDT)
From: "Stephen J. Gowdy" <gowdy@slac.stanford.edu>
X-X-Sender: gowdy@router-273.sgowdy.org
Reply-To: gowdy@slac.stanford.edu
To: Gunther Mayer <gunther.mayer@gmx.net>
cc: Peter =?iso-8859-1?Q?W=E4chtler?= <pwaechtler@loewe-komp.de>,
        Martin Dalecki <dalecki@evision-ventures.com>,
        <linux-usb-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>,
        <Linux-usb-users@lists.sourceforge.net>
Subject: Re: [Linux-usb-users] Re: What to do with all of the USB UHCI drivers
In-Reply-To: <3CEE4937.7C4E37AB@gmx.net>
Message-ID: <Pine.LNX.4.44.0205240812440.28256-100000@router-273.sgowdy.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I don't have a problem with the new names. Users shouldn't care, and when 
they do they want to report problems. It would help to know what they are 
actually talking about without need to remember which kernel the rename 
happened in (and that distributions may backport the changes to earlier 
kernels would only complicate this more).

On Fri, 24 May 2002, Gunther Mayer wrote:

> Peter Wächtler wrote:
> 
> > Martin Dalecki wrote:
> > > Uz.ytkownik Greg KH napisa?:
> > >
> > >> Anyway, here's the documentation that you need:
> > >>     The module usb-ohci is now gone.  Use ohci-hcd instead.
> > >>
> > >> The people with UHCI controllers have a big more documentation to read:
> > >>     The module uhci is now gone.  If you used this module, use
> > >>     uhci-hcd instead.  The module usb-uhci is now gone.  If you used
> > >>     this module, use usb-uhci-hcd instead.  If you have a preference
> > >>     over which UHCI module works better for you, please email
> > >>     greg@kroah.com your comments, as one of these modules will be
> > >>     going away in the near future.
> > >
> > >
> > > Thank's that is explaining it.
> > > But I would have loved it if it appeared with + in front in
> > > the patch somewhere. That's the only true problem I had.
> > > OK?
> > >
> > > BTW.> usb-ohci seems to be a more reasonable name, since
> > > it tells me directly - hey buddy I'm USB the -hcd doen't
> > > tell me anything in addition and is entierly redundant, or
> > > is there a ohci.o module there?
> > >
> > > And why not just doing the following.
> > >
> > > 1. Rename usb-ohci to usb-ohci-old
> > >
> > > 2. Rename ohci-hcd to usb-ohci
> > >
> > > Much less grief and guessing what happens :-).
> 
> Second this (in fact "first this").
> Elegant solution which would not only habe prevented this thread
> but help developers and users no end.
> 
> >
> > >
> > > Just a suggestion.
> > >
> >
> > You do not understand the _cause_ for the rename.
> 
> Martin and me understand what hcd means, and we think
> it is non-untuitive and user-hostile.
> 
> 
> >
> >
> > hcd stands for Host Controller Device. The names mark them as that.
> > Now you can argue, that all the SCSI controller modules do not have
> > HBC (host bus controller) in their name - and then look at the
> > different naming of the other scsi modules:
> >
> > scsi_mod.o  sd_mod.o  sg.o  sr_mod.o  st.o
> >
> > Also not very intuitiv. We could put them in different subdirs...
> 
> Obviously you cannot balance between intuitive and user-friendly.
> 
> 
> _______________________________________________________________
> 
> Don't miss the 2002 Sprint PCS Application Developer's Conference
> August 25-28 in Las Vegas -- http://devcon.sprintpcs.com/adp/index.cfm
> 
> _______________________________________________
> Linux-usb-users@lists.sourceforge.net
> To unsubscribe, use the last form field at:
> https://lists.sourceforge.net/lists/listinfo/linux-usb-users
> 

-- 
 /------------------------------------+-------------------------\
|Stephen J. Gowdy                     | SLAC, MailStop 34,       |
|http://www.slac.stanford.edu/~gowdy/ | 2575 Sand Hill Road,     |
|http://calendar.yahoo.com/gowdy      | Menlo Park CA 94025, USA |
|EMail: gowdy@slac.stanford.edu       | Tel: +1 650 926 3144     |
 \------------------------------------+-------------------------/

