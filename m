Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314841AbSECRLv>; Fri, 3 May 2002 13:11:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314799AbSECRLt>; Fri, 3 May 2002 13:11:49 -0400
Received: from mustard.heime.net ([194.234.65.222]:36003 "EHLO
	mustard.heime.net") by vger.kernel.org with ESMTP
	id <S314841AbSECRLT>; Fri, 3 May 2002 13:11:19 -0400
Date: Fri, 3 May 2002 19:10:52 +0200 (CEST)
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
X-X-Sender: roy@mustard.heime.net
To: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Martin Dalecki <dalecki@evision-ventures.com>,
        Pavel Machek <pavel@suse.cz>, <linux-kernel@vger.kernel.org>
Subject: Re: IDE hotplug support?
In-Reply-To: <20020502231359.W31556@unthought.net>
Message-ID: <Pine.LNX.4.44.0205031908170.27468-100000@mustard.heime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 May 2002, Jakob Østergaard wrote:

> On Thu, May 02, 2002 at 09:26:38PM +0100, Alan Cox wrote:
> > > >=20
> > > > 8 x 130MBy/s >>>> PCI bus throughput... I would rather recommend
> > > > a classical RAID controller card for this kind of
> > > > setup.
> > > 
> > > Because RAID controllers do not use the PCI bus ???    ;)
> > 
> > The raid card transfers the data once, software raid once per device for
> > Raid 1/5 - thats a killer.
> 
> For RAID-1 it's a killer (for writes), I agree.
> 
> But I really doubt it would be so horrible for RAID-5 - after all, it's only
> one extra block (the parity block) for each N-1 blocks written (for an N disk
> RAID-5).  The penalty should be less, the more disks you have in the array.
> 
> But seriously, has anyone out there ever seen a hardware RAID controller with
> a *sustained* RAID-5 thoughput of more than 60 MB/sec ?   Not that I think it
> is impossible, but I've never heard about it.  Enlighten me, please, and not
> with marketing numbers...

I was doing some testing on a Compaq ProLiant 380 (perhaps G2 - don't 
remember) that was doing some 70-80MB/s on a RAID-5. That was, however, on 
12 drives, 6 on each a controller. I managed to do a little more with JBOD 
and Linux Software RAID-5. That said, this was 18GB drives, which aren't 
the fastest drives on earth...

roy

-- 
Roy Sigurd Karlsbakk, Datavaktmester

Computers are like air conditioners.
They stop working when you open Windows.

