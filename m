Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277288AbRJEBfN>; Thu, 4 Oct 2001 21:35:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277298AbRJEBey>; Thu, 4 Oct 2001 21:34:54 -0400
Received: from femail7.sdc1.sfba.home.com ([24.0.95.87]:61871 "EHLO
	femail7.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S277297AbRJEBeb>; Thu, 4 Oct 2001 21:34:31 -0400
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
Reply-To: landley@trommello.org
Organization: Boundaries Unlimited
To: Vojtech Pavlik <vojtech@suse.cz>, Pavel Machek <pavel@suse.cz>
Subject: Re: Ethernet Error Correction
Date: Thu, 4 Oct 2001 17:34:17 -0400
X-Mailer: KMail [version 1.2]
Cc: Matti Aarnio <matti.aarnio@zmailer.org>,
        Karel Kulhavy <clock@atrey.karlin.mff.cuni.cz>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20010925223437.A21831@atrey.karlin.mff.cuni.cz> <20011002114801.A19015@atrey.karlin.mff.cuni.cz> <20011002115531.A7176@suse.cz>
In-Reply-To: <20011002115531.A7176@suse.cz>
MIME-Version: 1.0
Message-Id: <01100417341701.02393@localhost.localdomain>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 02 October 2001 05:55, Vojtech Pavlik wrote:
> On Tue, Oct 02, 2001 at 11:48:01AM +0200, Pavel Machek wrote:
>
> Well, if you checked all the cables, you'd most likely find the device
> capable of sending the bad CRC frames. Also, if you use a switch (not ha
> hub or coax), it won't work at all.

You can cause a lot of switches to degrate to HUB mode by overloading their 
arp cache mac address table thingy.  (Fun for packet sniffing when you've got 
a card that can change its mac address in software.  Send packets originating 
from a few thousand different mac IDs and watch the switch throw up its hands 
and go "AAAAAH!".  Sniffing the right init sequence for a pppoe connection 
with nonstandard authentication can be a bit difficult otherwise, with modern 
hardware... :)

I haven't tried it on a very wide variety of manufacturer's switches, though. 
 And I dunno how that relates to CRC behavior...

Rob
