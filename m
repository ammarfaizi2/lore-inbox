Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277371AbRKXMG3>; Sat, 24 Nov 2001 07:06:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277382AbRKXMGT>; Sat, 24 Nov 2001 07:06:19 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:53764
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S277371AbRKXMGB> convert rfc822-to-8bit; Sat, 24 Nov 2001 07:06:01 -0500
Date: Sat, 24 Nov 2001 04:04:16 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Martin Eriksson <nitrax@giron.wox.org>
cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: ATA is not crap. Propably.
In-Reply-To: <005301c174dc$d25ad5c0$0201a8c0@HOMER>
Message-ID: <Pine.LNX.4.10.10111240400050.844-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=X-UNKNOWN
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Martin,

PIIX4 AB/EB is a broken hardware mess.
HPT366 is another issue.
The newest driver should improve things but the latest unreleased fixes a
basic design error introduced some time ago by an unknown patch.  This has
been found and fixed.  Just need to find an ungreased turkey first to
test.

Regards,

Andre Hedrick
Linux ATA Development

On Sat, 24 Nov 2001, Martin Eriksson wrote:

> Sorry everyone I've upset.
> 
> The problem *seems* to be with my hard disks. Apparently both advertises
> udma2 capability but neither is capable?? When I run the disks on my
> "on-board" controller, I get a DMA timeout and the system comes to a halt
> (well only the HD activity, but you can't do much without access to the
> root/usr partition). When running on my HPT366 controller, I don't get the
> timeouts, but I do get the "slow responding system" at about the same time
> at which I get the timeouts on the PIIX4 controller. Problem comes when
> having copied about 11% of a 500'000'000 byte file from /dev/hdc7 to
> /dev/hda6...
> 
> The hard disks in question are models
> hda: ST36451A
> hdc: Maxtor 91152D8
> 
> The reason why I moved to the HPT366 controller in the first place, was
> because the onboard controller / BIOS? messed up the C/H/S values on one of
> the hard disks. Cannot be 100% sure though as this was a while ago (two
> years?).
> 
> _____________________________________________________
> |  Martin Eriksson <nitrax@giron.wox.org>
> |  MSc CSE student, department of Computing Science
> |  Umeå University, Sweden
> 
> 

