Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130847AbQK1VJm>; Tue, 28 Nov 2000 16:09:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130866AbQK1VJW>; Tue, 28 Nov 2000 16:09:22 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:62260 "EHLO
        the-village.bc.nu") by vger.kernel.org with ESMTP
        id <S130847AbQK1VJB>; Tue, 28 Nov 2000 16:09:01 -0500
Subject: Re: 2.2.16-22 (RedHat 7.0) fs problem
To: mal@gromco.com (Vladislav Malyshkin)
Date: Tue, 28 Nov 2000 20:38:27 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
In-Reply-To: <3A2413D8.69C18FF8@gromco.com> from "Vladislav Malyshkin" at Nov 28, 2000 03:21:44 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E140rWH-0004zC-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> when doing mount/umount of a MSDOS floppy on 2.2.16-22
> I often get
> 
> /var/log/messages.1:Nov 25 21:02:18 localhost kernel: set_blocksize: dev
> 02:00 buffer_dirty 19 size 512
> /var/log/messages.2:Nov 16 18:19:05 localhost kernel: set_blocksize: dev
> 02:00 buffer_dirty 19 size 512

It implies there were buffers still around that didnt get flushed. Its sort
of 'harmless but shouldnt happen'

> 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
