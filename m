Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292213AbSBTTE0>; Wed, 20 Feb 2002 14:04:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292212AbSBTTEQ>; Wed, 20 Feb 2002 14:04:16 -0500
Received: from otter.mbay.net ([206.40.79.2]:7440 "EHLO otter.mbay.net")
	by vger.kernel.org with ESMTP id <S292216AbSBTTEE> convert rfc822-to-8bit;
	Wed, 20 Feb 2002 14:04:04 -0500
From: John Alvord <jalvo@mbay.net>
To: Bill Davidsen <davidsen@tmr.com>
Cc: "Paulo J. Matos" <pocm@rnl.ist.utl.pt>, linux-kernel@vger.kernel.org
Subject: Re: Connecting through parallel port
Date: Wed, 20 Feb 2002 10:50:41 -0800
Message-ID: <str77ukfcime75ot3akiqb4f60d6t0urc6@4ax.com>
In-Reply-To: <87d6z03hnq.fsf@localhost.localdomain> <Pine.LNX.3.96.1020220103456.23280C-100000@gatekeeper.tmr.com>
In-Reply-To: <Pine.LNX.3.96.1020220103456.23280C-100000@gatekeeper.tmr.com>
X-Mailer: Forte Agent 1.8/32.553
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Feb 2002 10:39:36 -0500 (EST), Bill Davidsen
<davidsen@tmr.com> wrote:

>On 20 Feb 2002, Paulo J. Matos wrote:
>
>> I have a LAN at home and know I just got another computer to
>> connect to the LAN, I also found a parallel-parallel cable. The
>> network is ethernet, is it possible to connect the new computer
>> using the parallel ports of the computers to the server of the
>> LAN so that this new computer is able to have access to the
>> internet and the rest of stuff?
>> What do I need to configure in the kernel?
>> Is there any how-to out there that answers this question?
>
>There was a protocol called PLIP which did just what you want. I've used
>it many times for laptop install (Patrick even fixed it in Slackware at my
>request).
>
>Unfortunately, while the feature is still in recent 2.[45] kernels, it
>appears to be broken. The last laptop I installed needed a network card to
>get working.
>
>Note that using good cable and short runs you can push PPP over the serial
>ports at 230400bps, and possibly even use the bonding driver (or EQL) to
>hang several in parallel. I would think that was fast enough for casual
>use, although PL/IP was faster. I think the parport stuff is the cause,
>and it may be that only the config info need be changed, I just haven't
>chased it.
>
>Anyone having a fix or info that there's a workaround, fel free to expand
>on this!

This was interesting when NIC (network interface cards) cost $100.
Nowadays, they are a lot less costly and interest in the PLIP solution
has evaporated.

john
