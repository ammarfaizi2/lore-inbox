Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319192AbSHWTZQ>; Fri, 23 Aug 2002 15:25:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319217AbSHWTZQ>; Fri, 23 Aug 2002 15:25:16 -0400
Received: from kura.mail.jippii.net ([195.197.172.113]:13487 "HELO
	kura.mail.jippii.net") by vger.kernel.org with SMTP
	id <S319192AbSHWTZP>; Fri, 23 Aug 2002 15:25:15 -0400
Date: Fri, 23 Aug 2002 22:30:12 +0300
From: Anssi Saari <as@sci.fi>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.20-pre4-ac1
Message-ID: <20020823193012.GA12464@sci.fi>
Mail-Followup-To: Anssi Saari <as@sci.fi>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
References: <200208231046.g7NAk2914276@devserv.devel.redhat.com> <20020823163056.GA7426@sci.fi> <1030123089.5932.26.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1030123089.5932.26.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 23, 2002 at 06:18:09PM +0100, Alan Cox wrote:
> On Fri, 2002-08-23 at 17:30, Anssi Saari wrote:
> > Audio CD writes hog system if writing at > 4x so that CPU intensive
> > stuff like watching video goes poorly, frames are dropped a lot, even
> 
> Linux audio writes are currently always done PIO. Andrew Morton posted a
> patch for this which I need to dig out and merge.

I thought his patch concerns only reading audio. 

Anyway, what I forgot to mention that this slowdown doesn't occur if I
plug the writer to a Promise pdc20265 or CMD649, but both of those have
the random buffer underrun problem which I understand you know about.

That's with earlier kernels, up to 2.4.19-ac4, I haven't tried them
with newer ones, but it seems it's only the VIA 686b southbridge that
has this problem. I've tried the writer on an old Pentium system too,
which has an Intel PIIX3 and no problems with that.
