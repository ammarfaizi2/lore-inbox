Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261406AbVFHRkN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261406AbVFHRkN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 13:40:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261478AbVFHRjx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 13:39:53 -0400
Received: from stargate.chelsio.com ([64.186.171.138]:33148 "EHLO
	stargate.chelsio.com") by vger.kernel.org with ESMTP
	id S261452AbVFHRhq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 13:37:46 -0400
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.6944.0
Subject: RE: Kernel 2.6.12-rc6-mm1 & Chelsio driver
Date: Wed, 8 Jun 2005 10:33:09 -0700
Message-ID: <8A71B368A89016469F72CD08050AD3340255F0@maui.asicdesigners.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Kernel 2.6.12-rc6-mm1 & Chelsio driver
Thread-Index: AcVr9pTys51bBt7IQ4Se9tazsRAv7wAWY5Tt
From: "Scott Bardone" <sbardone@chelsio.com>
To: "Lukas Hejtmanek" <xhejtman@mail.muni.cz>
Cc: "Francois Romieu" <romieu@fr.zoreil.com>,
       "Jeff Garzik" <jgarzik@pobox.com>, <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lukas,

You can download the N210/N110 (ver 2.1.1) from the Chelsio website and use that driver for the T110 with a newer kernel. I have tested that driver up to the 2.6.11 kernel release. It will provide you NIC mode functinoality on your T110 TOE card, you can use it as a module, or try to patch it into a later kernel. If patching it into a kernel, you may need to modify the patch a bit.

-Scott


-----Original Message-----
From: Lukas Hejtmanek [mailto:xhejtman@mail.muni.cz]
Sent: Tue 6/7/2005 11:50 PM
To: Scott Bardone
Cc: Francois Romieu; Jeff Garzik; linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.6.12-rc6-mm1 & Chelsio driver
 
On Tue, Jun 07, 2005 at 07:19:46PM -0700, Scott Bardone wrote:
> It looks like you have a T110 card (10Gb TOE) by the device ID 0006.
> The Chelsio driver which is in the 2.6 mm tree only supports the NIC model 
> cards (N110 & N210).
> 
> We currently don't have the TOE API in the Linux kernel so the TOE 
> functionality does not exist, therefore you can only use the Chelsio 
> modified 2.6.6 kernel for TOE.
> 
> You will need to download the driver from Chelsio's website for the T110. 
> Please send me an email if you don't have a login.

Thanks, we have an account. But I wonder whether T110 card could be used in
newer kernel (as 2.6.6 is rather old and cat /proc/iomap segfaults in kernel).

We do not need TOE functionality, UDP transfer is just fine.

-- 
Lukás Hejtmánek



