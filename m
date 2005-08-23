Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750890AbVHWPvW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750890AbVHWPvW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 11:51:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751146AbVHWPvW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 11:51:22 -0400
Received: from tag.witbe.net ([81.88.96.48]:46304 "EHLO tag.witbe.net")
	by vger.kernel.org with ESMTP id S1750890AbVHWPvV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 11:51:21 -0400
Message-Id: <200508231551.j7NFpFD00513@tag.witbe.net>
Reply-To: <rol@witbe.net>
From: "Paul Rolland" <rol@witbe.net>
To: "'Sergey Vlasov'" <vsu@altlinux.ru>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [2.4.31] - USB device numbering in /proc/bus/usb
Date: Tue, 23 Aug 2005 17:51:37 +0200
Organization: Witbe
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
In-Reply-To: <20050823194548.6441d995.vsu@altlinux.ru>
Thread-Index: AcWn+ccpg/HpD6S2Qe+Iqvd7cDGEIAAAFlwQ
x-ncc-regid: fr.witbe
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Sergey,

> Yes.  Addresses for USB devices are assigned dynamically.  If you
> disconnect the modem from USB and connect it again, its address will
> change.

The problem I've is that nothing changed on the machine except that 
I did a reboot. Nothing (USB device) added, nothing removed, so with
a stable hardware config, USB numbering should have stayed stable, IMHO.
 
> > I would have been expecting some more stability in the 
> numbering across
> > reboot, the same way IDE disks numbers are stable.
> 
> Use some other identifier which is stable - e.g., serial number of the
> USB device (unfortunately, many devices don't have it).

Well yes, I'm going to try to convert to some other identifiers space
as this seems to be the only way to go.

Thanks for the confirmation,
Regards,
Paul
 

