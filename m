Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267241AbSK3N1h>; Sat, 30 Nov 2002 08:27:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267242AbSK3N1g>; Sat, 30 Nov 2002 08:27:36 -0500
Received: from [81.2.122.30] ([81.2.122.30]:2308 "EHLO darkstar.example.net")
	by vger.kernel.org with ESMTP id <S267241AbSK3N1g>;
	Sat, 30 Nov 2002 08:27:36 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200211301345.gAUDjoiZ000163@darkstar.example.net>
Subject: Re: hda: task_no_data_intr
To: gzp@myhost.mynet (Gabor Z. Papp)
Date: Sat, 30 Nov 2002 13:45:50 +0000 (GMT)
Cc: alan@redhat.com, linux-kernel@vger.kernel.org
In-Reply-To: <34e8.3de88c28.44a4f@gzp1.gzp.hu> from "Gabor Z. Papp" at Nov 30, 2002 10:00:08 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> What mean this message at boot time?
> 
> hda: task_no_data_intr: status=0x51 { DriveReady SeekComplete Error }
> hda: task_no_data_intr: error=0x04 { DriveStatusError }

I think that they are diagnostic messages that are a result of an old
disk not supporting some new commands that are being send to it.  I
thought this was done silently in the 2.4.x series - I see it on some
really old, (100 MB) disks running 2.5.x

I _think_ you can safely ignore it, but I am CCing Alan, because he
will know for certain.

> Tried with 3 different hard disks, and got the same message
> every time.

Are they all of a similar age/capacity?

> Seems like I'm also unable to make ext3 fs on the disks.

What is the exact problem?

John.
