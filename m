Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270571AbRHNLqW>; Tue, 14 Aug 2001 07:46:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270569AbRHNLqM>; Tue, 14 Aug 2001 07:46:12 -0400
Received: from alfik.ms.mff.cuni.cz ([195.113.19.71]:17171 "EHLO
	alfik.ms.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S270110AbRHNLqI>; Tue, 14 Aug 2001 07:46:08 -0400
Date: Sat, 11 Aug 2001 01:17:26 +0000
From: Pavel Machek <pavel@suse.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "Dirk W. Steinberg" <dws@dirksteinberg.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Swapping for diskless nodes
Message-ID: <20010811011726.E55@toy.ucw.cz>
In-Reply-To: <no.id> <E15UrVb-0007SG-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <E15UrVb-0007SG-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Thu, Aug 09, 2001 at 04:14:03PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > what you say sound a lot like a hacker solution ("check that it uses the
> > right GFP_ levels"). I think it's about time that this deficit of linux
> 
> Nope. I'm simply advising people to check that nbd is correctly written.

This bug is unlikely to be in nbd, but you need to check whole network
stack. Even arp handling is cruical for working nbd swap!
								Pavel
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

