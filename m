Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287933AbSBMRyc>; Wed, 13 Feb 2002 12:54:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287966AbSBMRyW>; Wed, 13 Feb 2002 12:54:22 -0500
Received: from mail.libertysurf.net ([213.36.80.91]:10022 "EHLO
	mail.libertysurf.net") by vger.kernel.org with ESMTP
	id <S287933AbSBMRyI> convert rfc822-to-8bit; Wed, 13 Feb 2002 12:54:08 -0500
Date: Tue, 12 Feb 2002 19:52:55 +0100 (CET)
From: =?ISO-8859-1?Q?G=E9rard_Roudier?= <groudier@free.fr>
X-X-Sender: <groudier@gerard>
To: "David S. Miller" <davem@redhat.com>
cc: <alan@lxorguk.ukuu.org.uk>, <ac9410@bellsouth.net>, <alan@clueserver.org>,
        <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.4 sound module problem
In-Reply-To: <20020213.013644.118972487.davem@redhat.com>
Message-ID: <20020212194558.H1561-100000@gerard>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 13 Feb 2002, David S. Miller wrote:

>    From: Alan Cox <alan@lxorguk.ukuu.org.uk>
>    Date: Wed, 13 Feb 2002 09:26:32 +0000 (GMT)
>
>    There are PCI drivers using the old sound code. Whether it matters is a
>    more complicated question as these devices use ISA DMA emulation or their
>    own pseudo DMA functionality.
>
> The sound layer PCI DMA stuff like a nice project for some kernel
> janitors :-))

Not worth, IMO.

Machines that give us fun support the legacy virt_to_bus() semantic.
Those that require the PCI DMA abstraction are so boring than adding sound
will probably not improve user pleasure significantly.

:-))     (this smiley is just to prevent from too much flaming ;-)

  Gérard.


