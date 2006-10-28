Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751151AbWJ1RDQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751151AbWJ1RDQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Oct 2006 13:03:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751160AbWJ1RDQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Oct 2006 13:03:16 -0400
Received: from smtp-out001.kontent.com ([81.88.40.215]:6887 "EHLO
	smtp-out.kontent.com") by vger.kernel.org with ESMTP
	id S1751151AbWJ1RDP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Oct 2006 13:03:15 -0400
From: Oliver Neukum <oliver@neukum.org>
To: Soeren Sonnenburg <kernel@nn7.de>
Subject: Re: usb initialization order (usbhid vs. appletouch)
Date: Sat, 28 Oct 2006 19:03:29 +0200
User-Agent: KMail/1.8
Cc: linux-usb-devel@lists.sourceforge.net,
       Linux Kernel <linux-kernel@vger.kernel.org>
References: <1161856438.5214.2.camel@no.intranet.wo.rk> <200610261436.47463.oliver@neukum.org> <1162054576.3769.15.camel@localhost>
In-Reply-To: <1162054576.3769.15.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610281903.29510.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Samstag, 28. Oktober 2006 18:56 schrieb Soeren Sonnenburg:
> Anyways, back to the above problem. Can one somehow tell the hid-core to
> load the appletouch driver when it detects any of these devices and then
> initialize on top of that ? The appletouch driver is completely ignored
> (doesn't even enter the atp_prope function as usb_register registers
> with device/product tuples that are already taken by hid....
> 
> Any ideas ?

Try udev to disconnect the hid driver, then load appletouch.

	HTH
		Oliver
