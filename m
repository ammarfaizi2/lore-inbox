Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262716AbTIQJsT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Sep 2003 05:48:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262718AbTIQJsT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Sep 2003 05:48:19 -0400
Received: from [203.124.210.99] ([203.124.210.99]:43982 "EHLO
	rocklines.oyeindia.com") by vger.kernel.org with ESMTP
	id S262716AbTIQJsR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Sep 2003 05:48:17 -0400
From: "msrinath" <msrinath@bplitl.com>
To: "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>
Cc: "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>
Subject: RE: Kernel NMI error
Date: Wed, 17 Sep 2003 15:21:33 +0530
Message-ID: <007c01c37d01$47622700$1d03000a@srinath>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.6604 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Importance: Normal
In-Reply-To: <1063718716.10036.10.camel@dhcp23.swansea.linux.org.uk>
X-Information: Please contact the ISP for more information
X-Kaspersky: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the reply. This is the only time this has ever happened. How can
I make out if it is a memory error? Is there any way by which I can test it?

Thanks & Regards,

- Srinath

-----Original Message-----
From: Alan Cox [mailto:alan@lxorguk.ukuu.org.uk]
Sent: 16 September 2003 18:55
To: msrinath
Cc: Linux Kernel Mailing List
Subject: Re: Kernel NMI error


On Maw, 2003-09-16 at 12:38, msrinath wrote:
> Recently one of our servers running RedHat linux 7.2 with 2.4.7-10 SMP
> kernel generated the following log and the system rebooted. This system
has
> 2 CPUs.

Typically an NMI is a system error. That could be a memory error, it
could be a freak power glitch if its only ever happened once.

If you are using a 2.4.7 kernel you really should also update to the
current errata kernel and other updates.



--
This message has been scanned for viruses and
dangerous content by Kaspersky on bpl Server, and is
believed to be clean.
bpl www.kaspersky.com
.


-- 
This message has been scanned for viruses and
dangerous content by Kaspersky on bpl Server, and is
believed to be clean.
bpl www.kaspersky.com
.

