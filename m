Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129734AbRBYUwG>; Sun, 25 Feb 2001 15:52:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129735AbRBYUv5>; Sun, 25 Feb 2001 15:51:57 -0500
Received: from oxmail3.ox.ac.uk ([129.67.1.180]:10472 "EHLO oxmail.ox.ac.uk")
	by vger.kernel.org with ESMTP id <S129734AbRBYUvu>;
	Sun, 25 Feb 2001 15:51:50 -0500
Message-ID: <3A99708A.679079C7@computing-services.oxford.ac.uk>
Date: Sun, 25 Feb 2001 20:52:26 +0000
From: A E Lawrence <adrian.lawrence@computing-services.oxford.ac.uk>
Organization: Not much
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, ian@wehrman.com, mhaque@haque.net,
        adilger@turbolinux.com, linux-kernel@vger.kernel.org
Subject: Re: EXT2-fs error
In-Reply-To: <E14Wi2k-00009c-00@the-village.bc.nu> <3A98360C.C7258FA6@computing-services.oxford.ac.uk> <3A983EDF.E56E6D47@computing-services.oxford.ac.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A E Lawrence wrote:
> 
> A E Lawrence wrote:
> >
> > Alan Cox wrote:
> > >
> > > > I have seen similar problems on stock 2.4.2 a machine which has not run
> > > > 2.4.1.
> > >
> > > What disk controllers ? We really need that sort of info in order to see the
> > > pattern in the odd reports of corruption we get
> 
> Problems have just started to show up under 2.2.18, so it is likely that
> the hardware has become flakey. Bit of a coincidence, unless it is a
> side effect of upgrading one of the packages for 2.4.2 :-( or a damaged
> library.
> 
> So you had better discount this report. Apologies.

Now investigated: the hardware has not changed. Rather the corruption
under 2.2.18 only happens when hdparm -d1 is executed. I guess that is
well reported, but I had forgotten if I ever knew :-(

In contrast 2.4.2 corruptions happen whether dma is explicitly turned on
by hdparm or not.

[IDE interface: VIA Technologies, Inc. VT82C586 IDE [Apollo] (rev 10)]

ael
-- 
A E Lawrence
