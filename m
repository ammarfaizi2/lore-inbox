Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265079AbSJWPz4>; Wed, 23 Oct 2002 11:55:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265082AbSJWPz4>; Wed, 23 Oct 2002 11:55:56 -0400
Received: from rztsun.rz.tu-harburg.de ([134.28.200.14]:5545 "EHLO
	rztsun.rz.tu-harburg.de") by vger.kernel.org with ESMTP
	id <S265079AbSJWPzy> convert rfc822-to-8bit; Wed, 23 Oct 2002 11:55:54 -0400
Content-Type: text/plain; charset=US-ASCII
From: Jan Dittmer <jan@jandittmer.de>
To: Jens Axboe <axboe@suse.de>
Subject: Re: Oops on boot with TCQ enabled (VIA KT133A)
Date: Wed, 23 Oct 2002 18:02:26 +0200
User-Agent: KMail/1.4.3
References: <200210190241.49618.jan@jandittmer.de> <20021020104601.C8606@ucw.cz> <20021020093818.GC24484@suse.de>
In-Reply-To: <20021020093818.GC24484@suse.de>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
       linux-ide@vger.kernel.org, Vojtech Pavlik <vojtech@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210231802.26447.jan@jandittmer.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Thanks for verifying that! Jan, you appeared to have problems even with
> tcq-per-default enabled and not touching the depth while running io, is
> that correct?

Just got this, but system seems to work stable though. What does it mean?

jan

Code: 0f 0b 35 02 b5 df 38 c0 68 30 d3 27 c0 68 20 4e 00 00 68 d0
 ide_tcq_intr_timeout: timeout waiting for completion interrupt
hda: invalidating tag queue (10 commands)
hda: status error: status=0x48 { DriveReady DataRequest }

hda: drive not ready for command
hda: status error: status=0x48 { DriveReady DataRequest }

hda: drive not ready for command
