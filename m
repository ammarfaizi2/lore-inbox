Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129183AbRAEFBu>; Fri, 5 Jan 2001 00:01:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129267AbRAEFBl>; Fri, 5 Jan 2001 00:01:41 -0500
Received: from quattro.sventech.com ([205.252.248.110]:61456 "HELO
	quattro.sventech.com") by vger.kernel.org with SMTP
	id <S129183AbRAEFBW>; Fri, 5 Jan 2001 00:01:22 -0500
Date: Fri, 5 Jan 2001 00:01:20 -0500
From: Johannes Erdfelt <johannes@erdfelt.com>
To: Keith Owens <kaos@ocs.com.au>
Cc: "Fr d ric L. W. Meunier" <0@pervalidus.net>, linux-kernel@vger.kernel.org
Subject: Re: make menuconfig: where's USB Mass Storage?
Message-ID: <20010105000119.D8324@sventech.com>
In-Reply-To: <20010105024211.B225@pervalidus> <18993.978670400@kao2.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4i
In-Reply-To: <18993.978670400@kao2.melbourne.sgi.com>; from Keith Owens on Fri, Jan 05, 2001 at 03:53:20PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 05, 2001, Keith Owens <kaos@ocs.com.au> wrote:
> On Fri, 5 Jan 2001 02:42:11 -0200, 
> Fr d ric L . W . Meunier <0@pervalidus.net> wrote:
> >Is this just me? Configuring 2.4.0 with make menuconfig with
> >CONFIG_EXPERIMENTAL=y I get no prompt for USB Mass Storage,
> >but the .config is saved with # CONFIG_USB_STORAGE is not set
> 
> CONFIG_USB_STORAGE is only available if you have both USB and SCSI
> selected.  Is that the correct combination?  I have no idea, but that
> is what is coded.

Yup, obviously USB is required, but USB storage devices are all SCSI
(atleast the class devices are), so we need the SCSI layer as well.

JE

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
