Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261586AbSJUTzY>; Mon, 21 Oct 2002 15:55:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261606AbSJUTzY>; Mon, 21 Oct 2002 15:55:24 -0400
Received: from mimas.island.net ([199.60.19.4]:50448 "EHLO mimas.island.net")
	by vger.kernel.org with ESMTP id <S261586AbSJUTzX>;
	Mon, 21 Oct 2002 15:55:23 -0400
Date: Mon, 21 Oct 2002 13:01:26 -0700 (PDT)
From: andy barlak <andyb@island.net>
Reply-To: <andyb@island.net>
To: Mike Anderson <andmike@us.ibm.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] scsi_error device offline fix
In-Reply-To: <20021021193335.GE1069@beaverton.ibm.com>
Message-ID: <Pine.LNX.4.30.0210211250340.12696-100000@tosko.alm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Sorry,  used the wrong dmesg file for the copy and paste of the error message.

yes the printk error message issued is:

scsi: Device offlined - not ready or command retry failed after error recovery:
host 0 channel 0 id 0 lun 0

over and over through all ids, existing or not.
Patch was successfully applied to 2.5.44.



On Mon, 21 Oct 2002, Mike Anderson wrote:

> andy barlak [andyb@island.net] wrote:
> >
> > This patch to scsi_error.c   make no improvement
> > in my BusLogic 958  difficulties.  Still get these messages
> > and timouts with the patch.
> >
> > scsi_eh_offline_sdevs: Device offlined - not ready or command retry failed after
> >  error recovery: host 0 channel 0 id 1 lun 0
> > .
> > .
> > .
> >
> > --
> >
> >  Andy Barlak
>
> Is the patch applied correctly?
>
> I the patch the printk is changed to "scsi:" instead of
> "scsi_eh_offline_sdevs:"
>
> -andmike
> --
> Michael Anderson
> andmike@us.ibm.com
>

-- 

 Andy Barlak


