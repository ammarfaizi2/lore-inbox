Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272721AbRILJoL>; Wed, 12 Sep 2001 05:44:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272723AbRILJoC>; Wed, 12 Sep 2001 05:44:02 -0400
Received: from nsd.netnomics.com ([216.71.84.35]:5928 "EHLO
	mandrakesoft.mandrakesoft.com") by vger.kernel.org with ESMTP
	id <S272721AbRILJno>; Wed, 12 Sep 2001 05:43:44 -0400
Date: Wed, 12 Sep 2001 05:43:15 -0400 (EDT)
From: Francis Galiegue <fg@mandrakesoft.com>
To: Manoj Sontakke <manojs@sasken.com>
cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Packet tapping
In-Reply-To: <3B9F2BC8.D647A7A@sasken.com>
Message-ID: <Pine.LNX.4.30.0109120542330.4681-100000@toy.mandrakesoft.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Sep 2001, Manoj Sontakke wrote:

>
> Hi,
> 	Is it possible to tap a packet and send it to a userlevel program
> before it is sent to appropriate receive function (say ip_rcv()). The
> user level program will give the packet back to the kernel for delivery
> to appropriate receive function.
> 	In short, is it possible to have a protocol stack (between layer 2 and
> 3) to be implemented in useland.
>
> 	Is Tun/Tap driver useful here?
>

Isn't the QUEUE driver from iptables done for such cases?

-- 
Francis Galiegue, fg@mandrakesoft.com - Normand et fier de l'être
"Programming is a race between programmers, who try and make more and more
idiot-proof software, and universe, which produces more and more remarkable
idiots. Until now, universe leads the race"  -- R. Cook

