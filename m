Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267911AbRHMBuf>; Sun, 12 Aug 2001 21:50:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269698AbRHMBu0>; Sun, 12 Aug 2001 21:50:26 -0400
Received: from femail27.sdc1.sfba.home.com ([24.254.60.17]:14004 "EHLO
	femail27.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S267911AbRHMBuO>; Sun, 12 Aug 2001 21:50:14 -0400
Content-Type: text/plain; charset=US-ASCII
From: Nicholas Knight <tegeran@home.com>
Reply-To: tegeran@home.com
To: "Paul G. Allen" <pgallen@randomlogic.com>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: Hang problem on Tyan K7 Thunder resolved -- SB Live! heads-up
Date: Sun, 12 Aug 2001 18:50:06 -0700
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010812155520.A935@ulthar.internal.mclure.org> <200108130100.f7D10YH07664@penguin.transmeta.com> <3B772E5A.392C37E8@randomlogic.com>
In-Reply-To: <3B772E5A.392C37E8@randomlogic.com>
MIME-Version: 1.0
Message-Id: <01081218500600.02092@c779218-a>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 12 August 2001 06:33 pm, Paul G. Allen wrote:
> Linus Torvalds wrote:
<snip>
> > Also, if you followed the other thread on the Tyan Thunder lockup,
> > you'll have noticed that it locked up under heavy PCI loads. At least
> > on that machine it stopped with the 2.4.8 driver.
>
> I hadn't read the entire thread, but I did see that heavy loads seemed
> to be a problem. I am running a GeForce 3 and when I play games or do
> other graphics related things - I have a few OpenGL projects I've been
> working on - I try sqeak every bit of detail and piece of "eye candy" I
> can out of the system, as well as the best available sound. I'd say
> running Quake 3 at 1600x1200x32 in multiplayer should be a heavy load
> on everything, including PCI.

Not neccisarily, the primary load when playing/displaying anything on a 
GeForce card is on the processor and the AGP bus, not the PCI, even the 
NIC wouldn't be putting too much load on PCI. If you had other 
configuration issues that Q3 accessing the HDD a lot, then you might have 
a high load on the PCI bus. (if you do, feel free to contact me 
privately, I may be able to help you tweak things so that you don't get a 
lot of HDD access under Q3)

<snip>
