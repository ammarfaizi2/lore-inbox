Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266723AbRGYOpv>; Wed, 25 Jul 2001 10:45:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266938AbRGYOpb>; Wed, 25 Jul 2001 10:45:31 -0400
Received: from secure.webhotel.net ([195.41.202.80]:62053 "HELO
	secure.webhotel.net") by vger.kernel.org with SMTP
	id <S266723AbRGYOpY>; Wed, 25 Jul 2001 10:45:24 -0400
X-BlackMail: 213.237.118.153, there,  <snowwolf@one2one-networks.com>, 213.237.118.153
X-Authenticated-Timestamp: 16:51:29(CEST) on July 25, 2001
Content-Type: text/plain; charset=US-ASCII
From: Allan Sandfeld Jensen <snowwolf@one2one-networks.com>
Organization: One2one Networks A/S
To: linux-kernel@vger.kernel.org
Subject: Re: ps2/ new data for mouse protocol (fwd msg attached)
Date: Wed, 25 Jul 2001 16:43:49 +0200
X-Mailer: KMail [version 1.2.9]
In-Reply-To: <3B5DB12D.2B9C205E@pcsystems.de> <20010725012334.L23404@arthur.ubicom.tudelft.nl> <3B5EA8F8.D8C0EDE7@t-online.de>
In-Reply-To: <3B5EA8F8.D8C0EDE7@t-online.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010725144531Z266723-720+6195@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Wednesday 25. July 2001 13:09, Gunther Mayer wrote:
> Erik Mouw wrote:
> > On Tue, Jul 24, 2001 at 07:32:29PM +0200, Nico Schottelius wrote:
> > > Have a look into the attached email before reading mine, please.
> > >
> > > Is it possible to find out about what those bytes are ?
> > > And is it possible to intergrate the support for other
> > > 3 bytes into the Linux kernel ?
> >
> > So they put information about four buttons in six bytes and call that
> > proprietary? ROFL! How hard can it be? I think it will be fairly
> > straight forward to reverse engineer the format, it can't be rocket
> > science.
>
> No need for this, just read the public available documentation !
>
> Proprietary != Secret.
>
> However, some mouse secrets from various sources I hacked in here:
> http://home.t-online.de/home/gunther.mayer/gm_psauxprint-0.01.c -

Very nice. I am currently looking for some info to solve a problem with 
thinkpads and logitech cordless mice over ps/2. Basicly the wheel doesnt 
work. Looking closer they dont respond to the imps/2 or mousemanps/2 
protocol. Since cordless mice are more common than thinkpads, I think the 
problem would be solved if it was with the mouse. So I am guessing the IBM 
defaults to just repeating standard ps/2 protocol, and you have to first 
trick that before you trick the mouse. Since it works in windows there IS a 
way...

Where do I find the public available protocols, and the secrets? :)

And for the list, who should I notify that I am working on autodetecting IBM 
thinkpad  ps/2 repeaters in mouse driver?

(And yes I know some of the work belongs in XFree and gpm)

-Allan Sandfeld (snowwolf)
