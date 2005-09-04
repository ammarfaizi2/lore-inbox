Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751042AbVIDTeA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751042AbVIDTeA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 15:34:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751048AbVIDTeA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 15:34:00 -0400
Received: from smtp3.libero.it ([193.70.192.127]:7816 "EHLO smtp3.libero.it")
	by vger.kernel.org with ESMTP id S1751042AbVIDTd7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 15:33:59 -0400
From: "Giampaolo Tomassoni" <Giampaolo@Tomassoni.biz>
To: "matthieu castet" <castet.matthieu@free.fr>,
       "Giampaolo Tomassoni" <g.tomassoni@libero.it>
Cc: "Francois Romieu" <romieu@fr.zoreil.com>, <linux-kernel@vger.kernel.org>,
       <linux-atm-general@lists.sourceforge.net>
Subject: R: R: R: [Linux-ATM-General] [ATMSAR] Request for review - update #1
Date: Sun, 4 Sep 2005 21:33:35 +0200
Message-ID: <NBBBIHMOBLOHKCGIMJMDCEIKEKAA.Giampaolo@Tomassoni.biz>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2670
In-Reply-To: <431B46DB.9070705@free.fr>
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Messaggio originale-----
> Da: matthieu castet [mailto:castet.matthieu@free.fr]
> Inviato: domenica 4 settembre 2005 21.11
> 
> ...omissis...
>
> The problem is that lot's of new devices implement part of their dsp 
> function in the kernel space instead of in the device.
> And as company don't want to publish their dsp algorith and open source 
> it, we can't have open source driver for it.
> 
> That the case for bewan device (that even include a libm in their 
> source) and for pulsar pci device...

Nonono: I meant exactly to do an open card with an open dsp software. Next time hardware producers will think twice before refraining from disclosing card details...

After all, most producers didn't ever need to disclose their firmware as long as it is a binary file to be uploaded to the card. But still it took a lot of time to have a working ADSL driver under Linux, just because producers didn't want to disclose port assignments and the like. I.e.: they preferred not to disclose anything instead that just refraining to disclose the firmware, which would had to be enough for their purposes.

This is a behaviour that the linux community shall discourage. Designing an open hardware and software solution for ADSL connection would be a great way to avoid something like this in the future... You don't disclose? I offer an alternative which bypasses you.

The matter is not so easy, however: the ADSL standard is complex and dsp software has to take into account a lot of ADSL "flavors" (DSLAM producers often offer enhancements to the standard way), but it shouldn't be too difficult to the linux community to put together the needed gray matter...

Cheers,

	giampaolo

