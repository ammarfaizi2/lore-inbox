Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269249AbRHQAcL>; Thu, 16 Aug 2001 20:32:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269226AbRHQAcC>; Thu, 16 Aug 2001 20:32:02 -0400
Received: from fungus.teststation.com ([212.32.186.211]:44812 "EHLO
	fungus.teststation.com") by vger.kernel.org with ESMTP
	id <S269212AbRHQAbx>; Thu, 16 Aug 2001 20:31:53 -0400
Date: Fri, 17 Aug 2001 02:31:48 +0200 (CEST)
From: Urban Widmark <urban@teststation.com>
To: Dennis Bjorklund <db@zigo.dhs.org>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: 2.2.19: d-link dfe530-tx, Transmit timed out
In-Reply-To: <Pine.LNX.4.33.0108161810440.18106-100000@cosmo.zigo.dhs.org>
Message-ID: <Pine.LNX.4.30.0108170219330.20670-100000@cola.teststation.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Aug 2001, Dennis Bjorklund wrote:

> kernel: via-rhine.c:v1.08b-LK1.0.0 12/14/2000  Written by Donald Becker
> kernel:   http://www.scyld.com/network/via-rhine.html
> kernel: eth1: VIA VT6102 Rhine-II at 0xe400, 00:50:ba:6e:76:63, IRQ 9.
> kernel: eth1: MII PHY found at address 8, status 0x782d advertising 01e1 Link 40a1.
> [...]
> kernel: eth1: Transmit timed out, status 0000, PHY status 782d, resetting..
> (a lot of these)
> 
> I know this thread was up a year ago but there doesn't seem to have been a
> solution.  I also remember that there where patches that was supposed to
> reset the card when this happens, but obviously they never got into the
> kernel.

I don't remember actual patches from a year ago. Current 2.4.x has code
that resets the via-rhine.

Since you run on 2.2 the drivers from www.scyld.com are an option (not
sure what the 2.4 status is on those). They are similar to the in-kernel
version but not identical. If you do test, any difference in behaviour is
intresting.


> I should probably throw out this stupid card and get something else. Any
> suggestion of a card working well in linux? The computer is a P90 so a

The 3c905C (3c59x) has been working just fine for me. But then so has the
via-rhine cards I have.

/Urban

