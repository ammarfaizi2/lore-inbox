Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286343AbSAXJzR>; Thu, 24 Jan 2002 04:55:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286447AbSAXJzI>; Thu, 24 Jan 2002 04:55:08 -0500
Received: from dns.uni-trier.de ([136.199.8.101]:41980 "EHLO
	rzmail.uni-trier.de") by vger.kernel.org with ESMTP
	id <S286343AbSAXJy6> convert rfc822-to-8bit; Thu, 24 Jan 2002 04:54:58 -0500
Date: Thu, 24 Jan 2002 10:54:55 +0100 (CET)
From: Daniel Nofftz <nofftz@castor.uni-trier.de>
X-X-Sender: nofftz@infcip10.uni-trier.de
To: Hans-Peter Jansen <hpj@urpla.net>
cc: Ed Sweetman <ed.sweetman@wmich.edu>,
        Daniel Nofftz <nofftz@castor.uni-trier.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] amd athlon cooling on kt266/266a chipset
In-Reply-To: <20020123222546.70E23141C@shrek.lisa.de>
Message-ID: <Pine.LNX.4.40.0201241050010.6560-100000@infcip10.uni-trier.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Jan 2002, Hans-Peter Jansen wrote:

> Just testing with ACPI power saving without amd_disconnect. I'm back to
> 45°C cpuwise, but without 14% background load from apmd. Looks nicer in
> gkrellm, but no measurable/noticable difference otherwise. Will stay at
> amd unconnected ACPI power savings for now.

as far as i know the normal acpi and apm idle calls will only save
marginaly power without the disconnect function. but if the function does
make problems your on the better way without it ... sadly there is no way
to "tweak" things right for boards wich hafe this problems , cause you
have only a switch (register in the northbridge) which you could trigger
... and if it does not worl allright with it, so only way is to not use
the function ... this is one of the reasons, way there is an flag you have
to set on the boot-prompt ... it is more easy to test and to deactivate if
it doesn't work

daniel


# Daniel Nofftz
# Sysadmin CIP-Pool Informatik
# University of Trier(Germany), Room V 103
# Mail: daniel@nofftz.de

