Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283381AbRLDUIV>; Tue, 4 Dec 2001 15:08:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283365AbRLDUGp>; Tue, 4 Dec 2001 15:06:45 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:31238 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S283427AbRLDUFn>; Tue, 4 Dec 2001 15:05:43 -0500
Subject: Re: question about kernel 2.4 ramdisk
To: padraig@antefacto.com (Padraig Brady)
Date: Tue, 4 Dec 2001 20:14:16 +0000 (GMT)
Cc: scho1208@yahoo.com (Roy S.C. Ho), david@gibson.dropbear.id.au,
        tachino@open.nm.fujitsu.co.jp, linux-kernel@vger.kernel.org
In-Reply-To: <3C0D2843.5060708@antefacto.com> from "Padraig Brady" at Dec 04, 2001 07:47:15 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16BLxI-0003Ic-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> wrt the ramfs leak (the referenced patch below worked for me),
> is the ramfs usage limits patch + this fix going into
> the official 2.4 soon as it was in the ac series for ages?

The -ac ramfs changes need the mm operations changes. Someone has to go
merge that with Andrea-vm then you can get ramfs fixed and accounting sorted
out in shmfs
