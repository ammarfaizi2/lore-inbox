Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283232AbRK2Ntc>; Thu, 29 Nov 2001 08:49:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283231AbRK2NtW>; Thu, 29 Nov 2001 08:49:22 -0500
Received: from etpmod.phys.tue.nl ([131.155.111.35]:62779 "EHLO
	etpmod.phys.tue.nl") by vger.kernel.org with ESMTP
	id <S283230AbRK2NtS>; Thu, 29 Nov 2001 08:49:18 -0500
Message-Id: <200111291345.fATDjse10335@gum09.etpnet.phys.tue.nl>
Date: Thu, 29 Nov 2001 14:45:51 +0100 (CET)
From: bart@etpmod.phys.tue.nl
Reply-To: bart@etpmod.phys.tue.nl
Subject: Re: umounts and sync
To: maftoul@esrf.fr
cc: linux-kernel@vger.kernel.org
In-Reply-To: <20011129143844.B3221@pcmaftoul.esrf.fr>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 29 Nov, Samuel Maftoul wrote:
> (re-)hello everyone,
> I'm currently writing a script for hotplug ieee1394 hard drives.
> I'm encountering troubles with something:
> my hotplug agent launch a script when you unplug the disk.
> This script calls umount.
[snip]

This is the same problem as with a PC floppy. Users need to know that
you need to unmount first, and then remove the disk. But maybe you can
make hotplug tell the user to put the disk back.

Bart

-- 
Bart Hartgers - TUE Eindhoven 
Get my GPG key at http://etpmod.phys.tue.nl/bart/pubkey.gpg 

