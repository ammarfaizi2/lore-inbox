Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130401AbRAKB4P>; Wed, 10 Jan 2001 20:56:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131333AbRAKB4F>; Wed, 10 Jan 2001 20:56:05 -0500
Received: from adsl-63-195-162-81.dsl.snfc21.pacbell.net ([63.195.162.81]:46087
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S130401AbRAKBz6>; Wed, 10 Jan 2001 20:55:58 -0500
Date: Wed, 10 Jan 2001 17:28:58 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Grant Grundler <grundler@cup.hp.com>, linux-kernel@vger.kernel.org,
        taggart@fc.hp.com, m.ashley@unsw.edu.au
Subject: Re: [PATCH] 2.2.18pre21 ide-disk.c for OB800
In-Reply-To: <E14GVPN-0001Iu-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.10.10101101725070.26556-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Jan 2001, Alan Cox wrote:

> > Wrong method.
> > 
> > APMD has to have the ablity to remember the state.
> > Spindown is basically a power reset to the drive.
> 
> Wrong answer, apmd if its swapped out doesnt get back in on some drives

Okay then are you wanting me to create a struct or bit mask to carry the
the device settings/mode that is set before an APM/ACPI event happens.

Regardless that the answer is wrong, somebody/thing has to keep a copy of
the device settings, and the case of swapout they get nuked.  Thus a
reprobe must happen. yes/no?

Andre Hedrick
Linux ATA Development

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
