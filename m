Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267479AbTAGSp4>; Tue, 7 Jan 2003 13:45:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267481AbTAGSp4>; Tue, 7 Jan 2003 13:45:56 -0500
Received: from hera.cwi.nl ([192.16.191.8]:45036 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S267479AbTAGSpx>;
	Tue, 7 Jan 2003 13:45:53 -0500
From: Andries.Brouwer@cwi.nl
Date: Tue, 7 Jan 2003 19:54:11 +0100 (MET)
Message-Id: <UTC200301071854.h07IsBH22403.aeb@smtp.cwi.nl>
To: Andries.Brouwer@cwi.nl, patmans@us.ibm.com
Subject: Re: IDs
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net, mdharm-kernel@one-eyed-alien.net,
       zwane@holomorphy.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> The id is not suitable as a user space name. Moreover,
>> it is a heuristic only, and user space needs unambiguous names.

> If we had a complete white/black list of devices with/without a unique id,
> there would be no ambiguity.

You mean for the devices on the white list.
But most devices will not be on the white list.

Our perceptions differ, I think. My impression is that chaos
is the norm, and well-behaved devices are the exception.
I find very good behaviour in fixed hard disks.
Stuff by Maxtor, Seagate, IBM, etc - a very small collection
of very experienced manufacturers with high quality products.
SCSI CDROM drives or tape drives or scanners are messier.
USB storage devices are much messier - very basic parts of the
protocol are regularly broken.
So to me the approach of an id together with a blacklist
seems unworkable.

As you say - we can make a best effort and get a string that
with some luck identifies the device uniquely. But no guarantees
given.

Maybe that again means that the S/Z distinction can be dropped.

Andries
