Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262014AbVFGW3D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262014AbVFGW3D (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 18:29:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262016AbVFGW3D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 18:29:03 -0400
Received: from scl-ims.phoenix.com ([216.148.212.222]:5156 "EHLO
	scl-exch2k.phoenix.com") by vger.kernel.org with ESMTP
	id S262014AbVFGW2z convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 18:28:55 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: stupid SATA questions
Date: Tue, 7 Jun 2005 15:28:51 -0700
Message-ID: <0EF82802ABAA22479BC1CE8E2F60E8C3216B53@scl-exch2k3.phoenix.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: stupid SATA questions
Thread-Index: AcVri09RfneyooUATCmXeWtJQDsd3wAJInAg
From: "Aleksey Gorelov" <Aleksey_Gorelov@Phoenix.com>
To: "Jeff Garzik" <jgarzik@pobox.com>, "Kumar Gala" <kumar.gala@freescale.com>
Cc: "Linux Kernel list" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 07 Jun 2005 22:28:54.0818 (UTC) FILETIME=[49E66820:01C56BB0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
>From: linux-kernel-owner@vger.kernel.org 
>[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Jeff Garzik
>Sent: Tuesday, June 07, 2005 11:01 AM
>To: Kumar Gala
>Cc: Linux Kernel list
>Subject: Re: stupid SATA questions
>
>Kumar Gala wrote:
>> These questions were posed to me and I was hoping someone would have 
>> better knowledge about the works and usage of SATA then I 
>do.  All of 
>> these questions are around understanding how important the 
>performance 
>> of PIO mode is.
>> 
>> How often would one run in PIO mode?  Why would one run in PIO mode?
>
>Never.  No idea.  :)

Some BIOSes/option ROMs do. Especially SATA RAID ones.
But unless you are using BIOS interrupts... 

Aleks

>
>Unless you have a broken device, or a command that cannot work 
>with DMA 
>(such as IDENTIFY DEVICE), PIO mode is quite pointless.  It is 
>emulated 
>under SATA, turned into FIS's on the SATA bus.
>
>	Jeff
>
>
>
>-
>To unsubscribe from this list: send the line "unsubscribe 
>linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
