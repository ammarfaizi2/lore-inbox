Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265099AbUFRKjm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265099AbUFRKjm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 06:39:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265100AbUFRKjm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 06:39:42 -0400
Received: from mail45.messagelabs.com ([140.174.2.179]:8117 "HELO
	mail45.messagelabs.com") by vger.kernel.org with SMTP
	id S265099AbUFRKjg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 06:39:36 -0400
X-VirusChecked: Checked
X-Env-Sender: justin.piszcz@mitretek.org
X-Msg-Ref: server-7.tower-45.messagelabs.com!1087555174!3667409
X-StarScan-Version: 5.2.10; banners=-,-,-
X-Originating-IP: [141.156.156.57]
X-MimeOLE: Produced By Microsoft Exchange V6.5.6944.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: RE: ACPI vs. APM - Which is better for desktop and why?
Date: Fri, 18 Jun 2004 06:39:00 -0400
Message-ID: <2E314DE03538984BA5634F12115B3A4E895296@email1.mitretek.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: ACPI vs. APM - Which is better for desktop and why?
Thread-Index: AcRUmVA9MtzyxwdmQzuSgT9VQIPpuAAhv60Q
From: "Piszcz, Justin Michael" <justin.piszcz@mitretek.org>
To: "Felipe Alfaro Solana" <felipe_alfaro@linuxmail.org>,
       "Justin Piszcz" <jpiszcz@lucidpixels.com>
Cc: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is there any performance degradation when using ACPI as it uses IRQ 9,
therefore forcing more devices to share IRQ's thus possibly decreasing
performance?


-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Felipe Alfaro
Solana
Sent: Thursday, June 17, 2004 2:27 PM
To: Justin Piszcz
Cc: linux-kernel@vger.kernel.org
Subject: Re: ACPI vs. APM - Which is better for desktop and why?

On Thu, 2004-06-17 at 13:10 -0400, Justin Piszcz wrote:
> I have enabled ACPI on my Dell GX1 (Pentium 3/500MHZ) machine and
disabled 
> APM, however, what are the benefits of using ACPI over APM?

Well, I can't tell for sure... ACPI is supposed to offer better power
management and battery usage for laptops, while being more flexible than
APM.

The truth is that on my laptop, both work equally well but since ACPI is
still less mature than APM, I chose to use ACPI in order to test it and
helping in its future development.

> 
> I am using Kernel 2.6.7
> 
> I see ACPI eats up an IRQ and does not share it:

I wouldn't mind about IRQ's...

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel"
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/


