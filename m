Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130515AbRCTRMw>; Tue, 20 Mar 2001 12:12:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130517AbRCTRMm>; Tue, 20 Mar 2001 12:12:42 -0500
Received: from [213.97.45.174] ([213.97.45.174]:45065 "EHLO pau.intranet.ct")
	by vger.kernel.org with ESMTP id <S130515AbRCTRMa>;
	Tue, 20 Mar 2001 12:12:30 -0500
Date: Tue, 20 Mar 2001 18:11:01 +0100 (CET)
From: Pau <linuxnow@terra.es>
X-X-Sender: <pau@pau.intranet.ct>
To: Alessandro Suardi <alessandro.suardi@oracle.com>
cc: lkml <linux-kernel@vger.kernel.org>, <jgarzik@mandrakesoft.com>
Subject: Re: PCMCIA serial CardBus support vanished in 2.4.3-pre3 and later
In-Reply-To: <3AB78CC5.E6D8E748@oracle.com>
Message-ID: <Pine.LNX.4.33.0103201808280.1701-100000@pau.intranet.ct>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Mar 2001, Alessandro Suardi wrote:

> > Removing "alias char-major-4 serial_cb" from modules.conf did the trick
> > and the serial driver worked flawlessly. Modules serial got loaded
> > instead.
>
> Cool... but I have used for a while serial_cb in kernel, not as a module
>  so there is nothing to remove here :) as for Jeff's surprise I have had
>  basically no problem in using kernel PCMCIA stuff in 2.4 series, apart
>  from the usual Tx hang bug of the Xircom.

I've been using it since first 2.3 series :)
I still have the Tx hang basically with NFS, but also when moving high
amount of Mb in the LAN.
I've moved from pcmcia-cs to hotplug and it works too :)

Pau

