Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131879AbRAEExr>; Thu, 4 Jan 2001 23:53:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131928AbRAEExh>; Thu, 4 Jan 2001 23:53:37 -0500
Received: from deliverator.sgi.com ([204.94.214.10]:45369 "EHLO
	deliverator.sgi.com") by vger.kernel.org with ESMTP
	id <S131879AbRAEEx0>; Thu, 4 Jan 2001 23:53:26 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: "Fr d ric L. W. Meunier" <0@pervalidus.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: make menuconfig: where's USB Mass Storage? 
In-Reply-To: Your message of "Fri, 05 Jan 2001 02:42:11 -0200."
             <20010105024211.B225@pervalidus> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 05 Jan 2001 15:53:20 +1100
Message-ID: <18993.978670400@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Jan 2001 02:42:11 -0200, 
Fr d ric L . W . Meunier <0@pervalidus.net> wrote:
>Is this just me? Configuring 2.4.0 with make menuconfig with
>CONFIG_EXPERIMENTAL=y I get no prompt for USB Mass Storage,
>but the .config is saved with # CONFIG_USB_STORAGE is not set

CONFIG_USB_STORAGE is only available if you have both USB and SCSI
selected.  Is that the correct combination?  I have no idea, but that
is what is coded.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
