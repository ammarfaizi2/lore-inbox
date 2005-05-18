Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262198AbVERLPZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262198AbVERLPZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 07:15:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262180AbVERLPX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 07:15:23 -0400
Received: from science.horizon.com ([192.35.100.1]:36393 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S262202AbVERLN3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 07:13:29 -0400
Date: 18 May 2005 11:13:28 -0000
Message-ID: <20050518111328.7115.qmail@science.horizon.com>
From: linux@horizon.com
To: linux-os@analogic.com
Subject: Re: Sync option destroys flash!
Cc: linux@horizon.com, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> hda: read_intr: status=0x51 { DriveReady SeekComplete Error }
>> hda: read_intr: error=0x10 { SectorIdNotFound }, LBAsect=6, sector=6
>> end_request: I/O error, dev 03:00 (hda), sector 6
>> unable to read partition table
> [SNIPPED...]
> 
> You can "fix" this by writing all sectors. Although the data is lost,
> the flash-RAM isn't. This can (read will) happen if you pull the
> flash-RAM out of its socket with the power ON.

Er... no.  Trying to write 8K to /dev/hda, I get the above error
on sector 15.

My *other* problems could be fixed by rewriting the affected sector, but
this one seems to be a doozy.  I never saw "SectorIdNotFound" before.

>  Notice : All mail here is now cached for review by Dictator Bush.

As long as he has to read it personally, that's fine.  I'll get some
small pleasure watching his lips move.
