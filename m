Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287471AbSAHAgT>; Mon, 7 Jan 2002 19:36:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287508AbSAHAgJ>; Mon, 7 Jan 2002 19:36:09 -0500
Received: from quattro-eth.sventech.com ([205.252.89.20]:54792 "EHLO
	quattro.sventech.com") by vger.kernel.org with ESMTP
	id <S287471AbSAHAgA>; Mon, 7 Jan 2002 19:36:00 -0500
Date: Mon, 7 Jan 2002 19:36:00 -0500
From: Johannes Erdfelt <johannes@erdfelt.com>
To: Michael Cohen <lkml@ohdarn.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: USB Lockups
Message-ID: <20020107193600.S10145@sventech.com>
In-Reply-To: <1010449229.4069.6.camel@ohdarn.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1010449229.4069.6.camel@ohdarn.net>; from lkml@ohdarn.net on Mon, Jan 07, 2002 at 07:20:29PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 07, 2002, Michael Cohen <lkml@ohdarn.net> wrote:
> More experience with USB lockups here.
> 
> I have an Apollo Pro (694x) and an Apollo Super South (686b),
> and it's interesting how quickly this machine freezes under 2.4.18-pre1.
> All I have to do is send about 100KiB/second over my NIC and the USB
> (moving the mouse and tapping on the keys on my USB HID devices causes
> a hard lock with no messages of any kind.  Can't even get a serial
> console.)
> Tried with UHCI and JE driver. JE doesn't recognize the USB controller
> half the time.  It seems to me that this is similar to the problem
> with a saturated PCI bus that someone posted a latency fix for.
> I'd appreciate any input.  A similar machine does this on windows as
> well, too.  BIOS is as late as it gets.

Doesn't recognize the USB controller half the time? This is something I
would expect to either work all of the time, or none of the time.

Do you get any error messages?

JE

