Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132575AbQL1Xis>; Thu, 28 Dec 2000 18:38:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132689AbQL1Xii>; Thu, 28 Dec 2000 18:38:38 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:30468 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S132575AbQL1XiX>; Thu, 28 Dec 2000 18:38:23 -0500
Subject: Re: 2.2.19 hard hang from userspace while accessing /dev/mdXX devices
To: jmerkey@vger.timpanogas.org (Jeff V. Merkey)
Date: Thu, 28 Dec 2000 23:09:34 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org, jmerkey@timpanogas.org
In-Reply-To: <20001228165948.A22926@vger.timpanogas.org> from "Jeff V. Merkey" at Dec 28, 2000 04:59:48 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14BmAx-0004RD-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> If you open a non-existant md device (i.e. /dev/md11) from userspace 
> with an open() call, then send an ioctl() command, it results in the
> following message then hard hangs the entire system if you attempt
> to open any /dev/mdXX device with a minor number greater than 10.  
> Used to work on 2.2.17.

What does 2.2.18 show and which raid patches are you using if any on them


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
