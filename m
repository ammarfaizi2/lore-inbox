Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265213AbSKEVEF>; Tue, 5 Nov 2002 16:04:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265223AbSKEVEF>; Tue, 5 Nov 2002 16:04:05 -0500
Received: from web20513.mail.yahoo.com ([216.136.174.44]:25514 "HELO
	web20513.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S265213AbSKEVEC>; Tue, 5 Nov 2002 16:04:02 -0500
Message-ID: <20021105211035.77935.qmail@web20513.mail.yahoo.com>
Date: Tue, 5 Nov 2002 13:10:35 -0800 (PST)
From: vasya vasyaev <vasya197@yahoo.com>
Subject: RE: Machine's high load when HIGHMEM is enabled
To: "Nakajima, Jun" <jun.nakajima@intel.com>, Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <F2DBA543B89AD51184B600508B68D4000F2ECDBA@fmsmsx103.fm.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

By the way, please CC all of your answers, because I'm
not soubscribed to the list.
Thank you.


--- "Nakajima, Jun" <jun.nakajima@intel.com> wrote:
> Also try to disable BIOS remapping in the BIOS setup
> menu, if any. I know
> some BIOS that forgot to reset the proper memory
> attribute in the MTRR(s)
> after the remapping.
> 
> Jun
> 
> > -----Original Message-----
> > From: Andrew Morton [mailto:akpm@digeo.com]
> > Sent: Monday, November 04, 2002 11:28 AM
> > To: vasya vasyaev
> > Cc: linux-kernel@vger.kernel.org
> > Subject: Re: Machine's high load when HIGHMEM is
> enabled
> > 
> > vasya vasyaev wrote:
> > >
> > > Hello,
> > >
> > > First of all - thanks to these people, who
> responded
> > > to my question.
> > >
> > > I have some news...
> > >
> > > I've tried kernels:
> > > 2.4.19 - the same result
> > > 2.5.44 - the same result
> > > 2.5.45 - the same result
> > >
> > > If I take 1 Gb of memory away, then computer
> works
> > > much better, faster (something like without
> enabled
> > > HIGHMEM at all).
> > > The same effect takes place if I say mem=1024M
> while
> > > physically box has 2Gb of RAM - everything is
> fine!
> > > But if I start HIGHMEM enabled kernel on this
> box (2Gb
> > > RAM), then it works too slowly...
> > >
> > 
> > Please ensure that the mtrr driver is enabled in
> kernel config,
> > boot with mem=2G and send the output of `cat
> /proc/mtrr'.
> > 
> > Also, `dmesg | head -120' would be interesting.



__________________________________________________
Do you Yahoo!?
HotJobs - Search new jobs daily now
http://hotjobs.yahoo.com/
