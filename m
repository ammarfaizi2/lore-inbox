Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284360AbRLHTNF>; Sat, 8 Dec 2001 14:13:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284364AbRLHTMz>; Sat, 8 Dec 2001 14:12:55 -0500
Received: from Hell.WH8.TU-Dresden.De ([141.30.225.3]:3076 "EHLO
	Hell.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
	id <S284360AbRLHTMy>; Sat, 8 Dec 2001 14:12:54 -0500
Message-ID: <3C126634.F3BBC941@delusion.de>
Date: Sat, 08 Dec 2001 20:12:52 +0100
From: "Udo A. Steinberg" <reality@delusion.de>
Organization: Disorganized
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.1-pre7 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.1-pre7 ide-cd module
In-Reply-To: <3C1235C4.BC20AC8E@wanadoo.fr> <20011208161847.GK11567@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> 
> Upon first load, could you cat /proc/sys/dev/cdrom/info? It would appear
> that the drive is sending zeroed data but not reporting a failure.
> 
> Is this a new problem?

Same problem here (2.5.1-pre), but the code is monolithic and not a module.

hde: ATAPI CD-ROM drive, 0kB Cache, DMA
                         ^^^^^^^^^
It used to work correctly before, which rules out a bad drive. Do you want
me to check which kernel broke it first?

Regards,
Udo.
