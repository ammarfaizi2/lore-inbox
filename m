Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131305AbRCHJ3C>; Thu, 8 Mar 2001 04:29:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131310AbRCHJ2x>; Thu, 8 Mar 2001 04:28:53 -0500
Received: from mx0.gmx.net ([213.165.64.100]:50342 "HELO mx0.gmx.net")
	by vger.kernel.org with SMTP id <S131305AbRCHJ2k>;
	Thu, 8 Mar 2001 04:28:40 -0500
Date: Thu, 8 Mar 2001 10:28:18 +0100 (MET)
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: linux-kernel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: IDE bug in 2.4.2-ac12?
From: Konrad Stopsack <konrad_lkml@gmx.de>
In-Reply-To: <20010308101559.A1051@suse.cz>
Message-ID: <11313.984043698@www29.gmx.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="4Ckj6UjgE2iN1+kY"
X-Priority: 3 (Normal)
X-Authenticated-Sender: #0009979400@gmx.net
X-Mailer: WWW-Mail 1.5 (Global Message Exchange)
X-Authenticated-IP: [141.76.11.162]
X-Flags: 0001
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Vojtech Pavlik wrote:
> On Thu, Mar 08, 2001 at 10:06:57AM +0100, Konrad Stopsack wrote:
> > Vojtech Pavlik wrote:
> > > On Thu, Mar 08, 2001 at 09:51:43AM +0100, Konrad Stopsack wrote:
> > > 
> > > > > I don't see any other way how the ZIP could have impact on the 
IDE
> 
> > HDD
> > > > > on a different IDE interface.
> > > > The 82c586b can be a chip with locked-together IDE controllers,
> can't
> > > it?
> > > 
> > > What do you mean by 'locked together'?
> > Nasty chips whose two IDE channels aren't really separated. On one IDE 
> > channel you either can use DMA or not. On these chips, switching off 
DMA
> 
> > at the second controller also disables DMA at the first.
> 
> Then this is not the case of the 586b. All four IDE drive transfer
> speeds are programmed separately.
> 
> > > I have two vt82c586b's here and one old vt82c586. All work fine with
> > > different drive combinations, one even has a CD-ROM and a ZIP on the
> > > secondary channel like yours.
> > 
> > Yeah, Ok. My combination SHOULD work without any problems...
> > 
> > What else could I do? Swap CD-ROM and ZIP? Try new 2.4.2-ac14 with
> command 
> > line parameters "ide0=dma ide1=nodma"?
> 
> I don't know. I'm attaching the very latest driver - but I doubt it
> changes anything.

Thank you. I'll try the 2.4.2-ac14 kernel and your driver.

cu Konrad

-- 
Konrad Stopsack - konrad@stopsack.de

Sent through GMX FreeMail - http://www.gmx.net
--4Ckj6UjgE2iN1+kY--

