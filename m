Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277703AbRJLOU6>; Fri, 12 Oct 2001 10:20:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277708AbRJLOUs>; Fri, 12 Oct 2001 10:20:48 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:49933 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S277703AbRJLOUl>; Fri, 12 Oct 2001 10:20:41 -0400
Subject: Re: kapm-idled Funny in 2.4.10-ac12?
To: kentborg@borg.org (Kent Borg)
Date: Fri, 12 Oct 2001 15:21:57 +0100 (BST)
Cc: laughing@shared-source.org (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <20011012101242.C19336@borg.org> from "Kent Borg" at Oct 12, 2001 10:12:42 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15s3CH-0007LG-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> extra CPU cycles (in 2.4.10-ac1) I now notice that xosview is showing
> CPU usage when things are quiet as hopping up and down, and top is
> reporting kapm-idled CPU usage as in the mid to high 50 percent range.
> 
> Under 2.4.10-ac1 top used to put kapm-idled in the very high 90
> percent range.
> 
> Does this mean my laptop will get less battery life?

Is your laptop logging messages in the process ? (dmesg)

One thing I changed in -ac was to do sane things when the apm idle request
comes back with "no" from the BIOS

Alan
