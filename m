Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129364AbRBAW0m>; Thu, 1 Feb 2001 17:26:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129550AbRBAW0c>; Thu, 1 Feb 2001 17:26:32 -0500
Received: from mserv1d.vianw.co.uk ([195.102.240.96]:23715 "EHLO
	mserv1d.vianw.co.uk") by vger.kernel.org with ESMTP
	id <S129364AbRBAW0b>; Thu, 1 Feb 2001 17:26:31 -0500
From: Alan Chandler <alan@chandlerfamily.org.uk>
To: linux-kernel@vger.kernel.org
Subject: Re: VT82C686A corruption with 2.4.x
Date: Thu, 01 Feb 2001 21:56:42 +0000
Organization: [private individual]
Message-ID: <95mj7t09q3cjo1m79r4b355upasl0h40vl@4ax.com>
In-Reply-To: <3A794945.5F652819@voicenet.com> <Pine.LNX.4.21.0102011137590.27273-100000@winds.org> <20010201190653.H2341@suse.cz>
In-Reply-To: <20010201190653.H2341@suse.cz>
X-Mailer: Forte Agent 1.8/32.548
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Feb 2001 19:06:53 +0100, Vojtech Pavlik wrote:

>On Thu, Feb 01, 2001 at 11:46:08AM -0500, Byron Stanoszek wrote:
>
>> Yeah, by bios does the same thing too on the Abit KT7(a).
>
>Ok, I'll remember this. This is most likely the cause of the problems
>many people had with the KT7 in the past.
>
I've had (I now have 2.4.1 with dma off) the problems with a KT7,
although according to the BIOS its set to 100FSB/33PCI and the option
to tweak the clock further is set to zero

One further thought though - 1/3 of 100 is actually 33.3333Mhz.  What
if the flexibility in the motherboard is actually causing the bus to
be exactly 1/3 of 100

Interpolating according to Byron Stanoszek's table  for UDMA-33 (where
I have the problem) this could have a not insignificant effect on the
paramter given the chip.


Alan

alan@chandlerfamily.org.uk
http://www.chandler.u-net.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
