Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136500AbREIOi6>; Wed, 9 May 2001 10:38:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136501AbREIOit>; Wed, 9 May 2001 10:38:49 -0400
Received: from [63.95.13.242] ([63.95.13.242]:16931 "EHLO
	zso-proxy.zeusinc.com") by vger.kernel.org with ESMTP
	id <S136500AbREIOif>; Wed, 9 May 2001 10:38:35 -0400
Message-ID: <001101c0d895$8bfe27f0$2d040a0a@zeusinc.com>
From: "Tom Sightler" <ttsig@tuxyturvy.com>
To: "Jeff Garzik" <jgarzik@mandrakesoft.com>,
        "Bill Nottingham" <notting@redhat.com>
Cc: <linux-kernel@vger.kernel.org>, <tytso@mit.edu>,
        "Alessandro Suardi" <alessandro.suardi@oracle.com>
In-Reply-To: <20010509093733.C18911@devserv.devel.redhat.com> <3AF94ACB.F3688AB@mandrakesoft.com>
Subject: Re: [PATCH] make Xircom cardbus modems work
Date: Wed, 9 May 2001 10:37:12 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Does the attached patch work for you?
>
> serial.c still has the basic problem that there is a logical disconnect
> between the pci_boards list and the pci-device-id list:  any device
> which is not PCI_CLASS_COMMUNICATION_SERIAL or
> PCI_CLASS_COMMUNICATION_MODEM will not get scanned.  The solution is to
> move the PCI ids into the probe list, before the class listing.  Ideally
> I would like to merge the Xircom cardbus fix with this fix, since they
> are both modifying the pci_board list and thus conflict.
>
> Except for the Xircom Cardbus update (based on your patch, Bill), this
> patch has been tested and is known to solve the problems reported to me
> which were caused by the logical disconnect.
>
> (Alessandro, Tom, tytso: the attached patch is updated for the changes
> in Bill's patch, so you haven't seen this version yet)
>
> Jeff

Just wanted to report that this patch finally fixes my Xircom Cardbus
adapter.  Works like a charm.

Thanks!!

Later,
Tom


