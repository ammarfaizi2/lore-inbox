Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314083AbSGLMI7>; Fri, 12 Jul 2002 08:08:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316089AbSGLMI6>; Fri, 12 Jul 2002 08:08:58 -0400
Received: from [195.63.194.11] ([195.63.194.11]:12037 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S314083AbSGLMI5> convert rfc822-to-8bit; Fri, 12 Jul 2002 08:08:57 -0400
Message-ID: <3D2EC778.7000203@evision-ventures.com>
Date: Fri, 12 Jul 2002 14:11:36 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0.0) Gecko/20020611
X-Accept-Language: pl, en-us
MIME-Version: 1.0
To: "H. Peter Anvin" <hpa@zytor.com>
CC: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: IDE/ATAPI in 2.5
References: <agl7ov$p91$1@cesium.transmeta.com>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

U¿ytkownik H. Peter Anvin napisa³:
> Okay, I have suggested this before, and I haven't quite looked at this
> in detail, but I would again like to consider the following,
> especially given the changes in 2.5:
> 
> Please consider deprecating or removing ide-floppy/ide-tape/ide-cdrom
> and treat all ATAPI devices as what they really are -- SCSI over IDE.
> It is a source of no ending confusion that a Linux system will not
> write CDs to an IDE CD-writer out of the box, for the simple reason
> that cdrecord needs access to the generic packet interface, which is
> only available in the nonstandard ide-scsi configuration.
> 
> There really seems to be no decent reason to treat ATAPI devices as
> anything else.  I understand the ide-* drivers contain some
> workarounds for specific devices, but those really should be moved to
> their respective SCSI drivers anyway -- after all, manufacturers
> readily slap IDE or SCSI interfaces on the same devices anyway.
> 
> Note that this is specific to ATAPI devices.  ATA hard drives are
> another matter entirely.


Right now the "votes" go like the following:

In favour of the scrap:

1. HPA.
2. Adam J. Richter.
3. Marcin Dalecki (basically due to give up on the idea
of gradual unification).
...

Against:

1. Bart³omiej ¯o³nierkiewcz.

I think we will need a vote from the "great decission maker".

So Linus what's your opinnion please?


