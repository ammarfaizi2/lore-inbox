Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286968AbSA1LRo>; Mon, 28 Jan 2002 06:17:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287003AbSA1LRe>; Mon, 28 Jan 2002 06:17:34 -0500
Received: from dns.uni-trier.de ([136.199.8.101]:22258 "EHLO
	rzmail.uni-trier.de") by vger.kernel.org with ESMTP
	id <S286968AbSA1LRY>; Mon, 28 Jan 2002 06:17:24 -0500
Date: Mon, 28 Jan 2002 12:17:18 +0100 (CET)
From: Daniel Nofftz <nofftz@castor.uni-trier.de>
X-X-Sender: nofftz@hades.uni-trier.de
To: Ed Sweetman <ed.sweetman@wmich.edu>
cc: Daniel Nofftz <nofftz@castor.uni-trier.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <preining@logic.at>, <ttonino@users.sourceforge.net>,
        <moffe@amagerkollegiet.dk>, <timothy.covell@ashavan.org>,
        <Dieter.Nuetzel@hamburg.de>, <nitrax@giron.wox.org>, <mpet@bigfoot.de>,
        <lkml@sigkill.net>, <pavel@suse.cz>, <vandrove@vc.cvut.cz>,
        <hpj@urpla.net>, <whitney@math.berkeley.edu>
Subject: Re: acpi-rouble/amd disconnect patch
In-Reply-To: <1011968738.22709.29.camel@psuedomode>
Message-ID: <Pine.LNX.4.40.0201281211520.21970-100000@hades.uni-trier.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 25 Jan 2002, Ed Sweetman wrote:

> It sounds like you'll have to make the patch work just for Athlon XP's
> ...  unless of course you're not expecting it to be included in the
> kernel ever.

hmmm ...
i am not quite shure that this is only working with an xp processor ... at
the moment i'm looking for some additional informations, how to tune the
processor registers to implement the fix for the errata 11 bug. it must be
possible from within the kernel to do this. you have to modify the
CLK_CTRL MSR to a different value. i hope amd will send me the document
#24478 where the right values are described ...
has someone experiences how to modify msr ? i found 2 assambler commands
("rdmsr/wtmsr") but i have no experiences with assamambler ...

daniel



# Daniel Nofftz
# Sysadmin CIP-Pool Informatik
# University of Trier(Germany), Room V 103
# Mail: daniel@nofftz.de

