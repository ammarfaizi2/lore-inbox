Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263254AbSJHVpU>; Tue, 8 Oct 2002 17:45:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263255AbSJHVpU>; Tue, 8 Oct 2002 17:45:20 -0400
Received: from modemcable061.219-201-24.mtl.mc.videotron.ca ([24.201.219.61]:37760
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S263254AbSJHVpT>; Tue, 8 Oct 2002 17:45:19 -0400
Date: Tue, 8 Oct 2002 17:36:16 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Mikael Pettersson <mikpe@csd.uu.se>
cc: Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][2.5][RFT] 3c509-ethtool and then some, take 2
In-Reply-To: <15779.10216.623962.179406@kim.it.uu.se>
Message-ID: <Pine.LNX.4.44.0210081732580.14579-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Oct 2002, Mikael Pettersson wrote:

> Zwane Mwaikambo writes:
>  > 	This should take care of it i think. From what you describe it 
>  > looks like you're taking an interrupt right after we did a switch to 
>  > window 4 when we do a spin_unlock_irq.
>  > 
>  > Mikael any testing is much appreciated, can you also try switching 
>  > to full duplex?
> 
> Tested on a 3c509B combo TP/AUI PnP card. Status check didn't kill the link.
> Switching to AUI and back to TP worked. Attempt to switch to 100Mbps gave an
> error but had no ill effects. Switching to full duplex (talking to a 3c575_cb
> over a crossover cable) worked, as did going back to half duplex.

Thanks for the pretty extensive test!

> But what's up with the driver date? October 16th is about a week in the future :-)

I'll fix that in the final ;)

	Zwane
--
function.linuxpower.ca

