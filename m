Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277798AbRKSLVk>; Mon, 19 Nov 2001 06:21:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278078AbRKSLVb>; Mon, 19 Nov 2001 06:21:31 -0500
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:6119 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S277798AbRKSLVV>; Mon, 19 Nov 2001 06:21:21 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Mon, 19 Nov 2001 22:21:35 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15352.60223.1832.897635@notabene.cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Devlinks.  Code.  (Dcache abuse?)
In-Reply-To: message from Alan Cox on Monday November 19
In-Reply-To: <15352.57742.799052.405674@notabene.cse.unsw.edu.au>
	<E165mO5-0006En-00@the-village.bc.nu>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday November 19, alan@lxorguk.ukuu.org.uk wrote:
> > I think you missed part of my point.
> > There are lots of different name spaces in the kernel.
> > Filesystem names.  Driver names.  Module names.
> > 
> > But the namespace that is the current issue, the namespace of
> > currently available devices, is not a namespace where I would expect
> > trademarks to ever come up.  It is name space of interfaces and
> > instances.
> 
> You mean like adaptec/aic7xxx/0 for the first aic7xxx controller when you
> want to refer to an adaptec card ? And yes - you do need the ability to do
> that kind of thing, not just talk generically about "disks".
> 
> So I still seek an answer. "Shrug, probably wont happen" isnt a good
> one

I was thinking:

   devid/9005/00cf/0

Now maybe the numbers can be trade marks too (I always liked "S3"'s id: 5333).
However this number is extracted from the device in question.  Surely
if I have a device that reports itself as "9005:00cf", then there can
be no trademark violation in addressing the device as "the one which
calls itself 9005:00cf".
There may well be cases where a textual name in more appropriate 
  camera/Kodak DX3115/0/3/thumbnail
but if it is a name that you extract from the device, then you should
be safe.  If there is a trademark violation, then it is in the device,
not in the operating system.

I guess that leaves

 sound/SoundBlaster100%Compatible/

as a potential problem...  but if the device is sold as "100%
Soundblaster compatible", then any trade mark has already been
violated.

I appreciate that "Shrug, probably wont happen" isn't really good
enough, but we cannot stop development of generic kernel facilities
out of fear of reprisals.

NeilBrown

> 
> Alan
