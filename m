Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131542AbRCXBgh>; Fri, 23 Mar 2001 20:36:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131545AbRCXBg2>; Fri, 23 Mar 2001 20:36:28 -0500
Received: from munk.apl.washington.edu ([128.95.96.184]:1799 "EHLO
	munk.apl.washington.edu") by vger.kernel.org with ESMTP
	id <S131542AbRCXBgJ>; Fri, 23 Mar 2001 20:36:09 -0500
Date: Fri, 23 Mar 2001 17:31:47 -0800 (PST)
From: Brian Dushaw <dushaw@munk.apl.washington.edu>
To: David Balazic <david.balazic@uni-mb.si>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: VIA vt82c686b  and UDMA(100)
In-Reply-To: <3ABB5C3D.2C29962A@uni-mb.si>
Message-ID: <Pine.LNX.4.30.0103231727400.5652-100000@munk.apl.washington.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks to all for their advice on this problem.  So far I've tried
hdparm flags six ways from sunday to no effect, but I have yet to
try suggestions such as those below.  Alas I have to set aside this
problem for the next few weeks.

In the mean time, I note that the linux machines at my Lab are being
subjected to fairly severe security attacks at the moment (the latest
involved a hold in the bind DNS server (?) ) - a reminder
to all to keep applying those updates and security patches.

B.D.

On Fri, 23 Mar 2001, David Balazic wrote:

> Brian Dushaw (dushaw@munk.apl.washington.edu) wrote :
>
> > Dear Linux Kernel Wisemen,
> >    I have been following the discussion of the VIA vt82c686b chipset
> > and the troubles people have had in getting UDMA(100) to work. This
> > is to report that I have now tried the 2.4.2-ac20 kernel and the
> > 2.2.18 kernel with Andre's patch (dated March 20) and neither of
> > them get the disk speed up to where it ought to be. hdparm -t reports
> > back 11 MB/s or so for either kernel.
> >    VIA82CXXX enabled, and I also tried the ide0=ata66 flag, in desparation.
> >    At boot up both kernels report the disk as UDMA(100) - everything
> > seems to be peachy keen, but for the sluggish disk performance.
> >
> > Merely a report from the front lines,
> >
> > B.D.
>
> Do you also have IDE_AUTO_WHATEVER option enabled ,
> as suggested ( no, commanded ) in the VIA_IDE_OPTION help text ?
> ( press '?' when selecting the VIA IDE driver option )
>
> cat /proc/ide/via ?
>
> What do you think is the "correct" transfer rate of the disk ?
>
> For the record , I have a MSI K7T Pro2A board ( VIA KT133 with a
> vt82c686b south bridge ) and a IBM DTLA 307045 hard drive on a 80
> wire IDE cable ( set to CABLE-SELECT , connected to the end connector;
> you must always first use both connectors on the end of the cable !
> never left one end unused )
>
> Without doing any settings with hdparm, I get the full transfer rate
> of the disk, measured with hdparm : ~35MB/s
>
>
> kernel is 2.4.recent or redhat recent 2.4.x versions.
>
>

-- 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Brian Dushaw
Applied Physics Laboratory
University of Washington
1013 N.E. 40th Street
Seattle, WA  98105-6698
(206) 685-4198   (206) 543-1300
(206) 543-6785 (fax)
dushaw@apl.washington.edu

Web Page:  http://staff.washington.edu/dushaw/index.html

