Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269717AbUJAIFU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269717AbUJAIFU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 04:05:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269727AbUJAIFT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 04:05:19 -0400
Received: from mailgate01.slac.stanford.edu ([134.79.18.80]:2189 "EHLO
	mailgate01.slac.stanford.edu") by vger.kernel.org with ESMTP
	id S269717AbUJAIEi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 04:04:38 -0400
Date: Fri, 1 Oct 2004 10:03:45 +0200 (CEST)
From: "Stephen J. Gowdy" <gowdy@slac.stanford.edu>
X-X-Sender: gowdy@antonia.sgowdy.org
Reply-To: "Stephen J. Gowdy" <gowdy@slac.stanford.edu>
To: WHarms@bfs.de
cc: linux-kernel@vger.kernel.org, linux-usb-users@lists.sourceforge.net
Subject: Re: [Linux-usb-users] USB Stick with strange behavier
In-Reply-To: =?X-UNKNOWN?Q?=3Cvines=2EsxdD+j01=CC=2CA=40SZKOM=2EBFS=2EDE=3E?=
Message-ID: <Pine.LNX.4.58.0410011002410.6695@antonia.sgowdy.org>
References: =?X-UNKNOWN?Q?=3Cvines=2EsxdD+j01=CC=2CA=40SZKOM=2EBFS=2EDE=3E?=
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-PMX-Version: 4.6.0.99824
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Do you have any kernel logs when you connect the device on "computer 1"?
Also, can you look in /proc/interrupts to see if your USB Host Controller
is getting interrupts?

On Thu, 30 Sep 2004 WHarms@bfs.de wrote:

> Hi list,
> here are the results from ONE usb stick attached to computer 1 and computer 2. *Both* boxes have  SuSE 9.1 installed. (Kernel 2.6.4 +SuSE patches)
>
> the usb stick doesnt seem to work on computer 1 but performs perfecly on computer 2.
>
>
> computer 1
> desktop with msi k7n2/v board, usb 2.0
>
> computer 2
> Notebook acer 620, USB 1.1
>
>
> mfg
> wh
>
>
>
> /* computer 1 */
> # cat usb-storage/2
>    Host scsi2: usb-storage
>        Vendor: Prolific Technology Inc.
>       Product: Mass Storage Device
> Serial Number: None
>      Protocol: 8070i
>     Transport: Bulk
>        Quirks:
>
> # cat scsi
> Attached devices:
> Host: scsi2 Channel: 00 Id: 00 Lun: 00
>   Vendor: EUDAR    Model: Marchi2.0        Rev: P1.0
>   Type:   Direct-Access                    ANSI SCSI revision: 02
>
> # lsusb
> Bus 003 Device 007: ID 067b:2517 Prolific Technology, Inc.
> Bus 003 Device 006: ID 067b:2515 Prolific Technology, Inc.
> Bus 003 Device 001: ID 0000:0000
> Bus 002 Device 001: ID 0000:0000
> Bus 001 Device 001: ID 0000:0000
>
> /* computer 2 */
>
> # lsusb
> Bus 003 Device 001: ID 0000:0000
> Bus 002 Device 003: ID 1043:8006 iCreate Technologies Corp.
> Bus 002 Device 001: ID 0000:0000
> Bus 001 Device 001: ID 0000:0000
>
>  # cat scsi
> Attached devices:
> Host: scsi1 Channel: 00 Id: 00 Lun: 00
>   Vendor: USB2.0   Model: DISK             Rev: %z!Y
>   Type:   Direct-Access                    ANSI SCSI revision: 02
>
> # cat usb-storage/1
>    Host scsi1: usb-storage
>        Vendor: Generic
>       Product: Flash Disk
> Serial Number: None
>      Protocol: Transparent SCSI
>     Transport: Bulk
>        Quirks:
>
>
>
> -------------------------------------------------------
> This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
> Use IT products in your business? Tell us what you think of them. Give us
> Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
> http://productguide.itmanagersjournal.com/guidepromo.tmpl
> _______________________________________________
> Linux-usb-users@lists.sourceforge.net
> To unsubscribe, use the last form field at:
> https://lists.sourceforge.net/lists/listinfo/linux-usb-users
>

--
 /------------------------------------+-------------------------\
|Stephen J. Gowdy                     | SLAC, MailStop 34,       |
|http://www.slac.stanford.edu/~gowdy/ | 2575 Sand Hill Road,     |
|http://calendar.yahoo.com/gowdy      | Menlo Park CA 94025, USA |
|EMail: gowdy@slac.stanford.edu       | Tel: +1 650 926 3144     |
 \------------------------------------+-------------------------/
