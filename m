Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288969AbSBMV4m>; Wed, 13 Feb 2002 16:56:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288996AbSBMV4Z>; Wed, 13 Feb 2002 16:56:25 -0500
Received: from mail.pha.ha-vel.cz ([195.39.72.3]:41744 "HELO
	mail.pha.ha-vel.cz") by vger.kernel.org with SMTP
	id <S288969AbSBMVyy>; Wed, 13 Feb 2002 16:54:54 -0500
Date: Wed, 13 Feb 2002 22:54:49 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Ville Herva <vherva@twilight.cs.hut.fi>,
        Mark Cooke <mpc@star.sr.bham.ac.uk>, linux-kernel@vger.kernel.org
Subject: Re: Quick question on Software RAID support.
Message-ID: <20020213225449.B10409@suse.cz>
In-Reply-To: <E16axOE-0004zX-00@the-village.bc.nu> <Pine.LNX.4.44.0202131824530.29582-100000@pc24.sr.bham.ac.uk> <20020213213341.GI1105@niksula.cs.hut.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020213213341.GI1105@niksula.cs.hut.fi>; from vherva@niksula.hut.fi on Wed, Feb 13, 2002 at 11:33:41PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2002 at 11:33:41PM +0200, Ville Herva wrote:
> On Wed, Feb 13, 2002 at 06:30:01PM +0000, you [Mark Cooke] wrote:
> > Hi Alan,
> > 
> > Just a note that I have almost exactly the setup you outlined on a 
> > KT7A-RAID, HPT370 onboard.
> > 
> > I have a single disk on each highpoint chain, and a 3rd (parity) on 
> > one of the onboard 686B channels.
> > 
> > I have been seeing odd corruptions since I setup the system as RAID-5 
> > though.  Have you seen any reports of 686B ide corruption recently (or 
> > RAID-5 for that matter) ?
> > 
> > kernel 2.4.18pre6... just compiling pre9-ac3...
> > Athlon MP 1500+, mem=nopentium apm=off, NvAGP=0 in X-setup.
> 
> After months of testing, we found that KT7-RAID (we tested KT7A-RAID as
> well) is basicly impossible to get working reliably. It *always* corrupted
> data from HPT370, no matter what we tried. It seemed VIA PCI problem as
> things like the pci slot of the nic, network load, nic model etc greatly
> affected corruption rate. (Via 686b ide never corrupted data, but then again
> it's integrated in the south bridge and perhaps avoids full PCI path). Our
> combination was software RAID0 (one disk on ide2 and ide3 (HPT370
> channels)).
> 
> We ditched the board deep, took an Abit ST6-RAID (i815+HPT370) and have had
> no problems since. 
> 
> My position is that for heavy PCI load (additional IDE adapters etc), stay
> away from Via.
> 
> BTW: I have a little program to stress the raid volume (or any disk device
> for that matter) that I used to trigger the corruption. It is destructive
> for the data, though. I can mail it to you, if you like.

I'd like to try that, too, so if you can send me the program ...

-- 
Vojtech Pavlik
SuSE Labs
