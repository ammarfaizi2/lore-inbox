Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280954AbRKLUGk>; Mon, 12 Nov 2001 15:06:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280961AbRKLUG1>; Mon, 12 Nov 2001 15:06:27 -0500
Received: from mail028.mail.bellsouth.net ([205.152.58.68]:3894 "EHLO
	imf28bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S280954AbRKLUGP>; Mon, 12 Nov 2001 15:06:15 -0500
Message-ID: <3BF02BA4.D7E2D70E@mandrakesoft.com>
Date: Mon, 12 Nov 2001 15:05:56 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.14 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Frank de Lange <lkml-frank@unternet.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: Abysmal interactive performance on 2.4.linus
In-Reply-To: <20011112205551.A14132@unternet.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Frank de Lange wrote:
> 
> On a 768 MB SMP box (2x466 MHz Celeron), I see some weird problems with
> interactive performance on 2.4.15pre{1,2}. A good example of this is the
> following scenario:
> 
>  - copy a large file (eg. an iso image file) to a directory on the same
>    (reiserfs in this case) filesystem, or...
>  - do a filesystem comparison between a CD and the original file (with cmp
>    /mnt/cdrom/<filename> /mnt/reiserfs/1/data/<original_file_location>, using a
>    PLEXTOR Model: CD-ROM PX-40TS SCSI CD-ROM drive),
> 
>  - and THEN (while the copy or comparison runs) try any simple command (like
>    'ls /mnt/reiserfs/1/data' or 'top' or anything else...).
> 
> Response time is abysmal, a simple 'ls /some/dir' takes tens of seconds to
> start. Once the command is running, performance is normal. Try this when a
> cdrecord session is running and you'll get a buffer underrun.

Can you try 2.4.13ac6 (not 7/8), and 2.2.20, and post a comparison?

-- 
Jeff Garzik      | Only so many songs can be sung
Building 1024    | with two lips, two lungs, and one tongue.
MandrakeSoft     |         - nomeansno

