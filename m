Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132727AbRDXDJd>; Mon, 23 Apr 2001 23:09:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132733AbRDXDJX>; Mon, 23 Apr 2001 23:09:23 -0400
Received: from quattro.sventech.com ([205.252.248.110]:31751 "HELO
	quattro.sventech.com") by vger.kernel.org with SMTP
	id <S132727AbRDXDJN>; Mon, 23 Apr 2001 23:09:13 -0400
Date: Mon, 23 Apr 2001 23:09:12 -0400
From: Johannes Erdfelt <johannes@erdfelt.com>
To: josh <skulcap@mammoth.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: USB problems since 2.4.2
Message-ID: <20010423230911.M12435@sventech.com>
In-Reply-To: <Pine.LNX.4.20.0104232027400.12476-100000@www>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4i
In-Reply-To: <Pine.LNX.4.20.0104232027400.12476-100000@www>; from josh on Mon, Apr 23, 2001 at 08:49:11PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 23, 2001, josh <skulcap@mammoth.org> wrote:
> Kernel: 2.4.2 - latest (2.4.3-ac12)
> Platform: x86 on mangled Slack7.1
> Hardware: MSI 694D Pro-AR
> ( http://www.msicomputer.com/products/detail.asp?ProductID=150 )
> 
> Problem: USB devices timeout on address assignment. Course thats with the
> non JE driver, with the JE driver the bus doesnt even say that anything
> gets connected.
> 
> when any device is plugged in:
> *************************************
> hub.c: USB new device connect on bus1/1, assigned device number 4
> usb_control/bulk_msg: timeout
> usb.c: USB device not accepting new address=4 (error=-110)
> hub.c: USB new device connect on bus1/1, assigned device number 5
> usb_control/bulk_msg: timeout
> usb.c: USB device not accepting new address=5 (error=-110)
> *************************************

Can you try booting your kernel with the "noapic" option and see if it
still happens?

JE

