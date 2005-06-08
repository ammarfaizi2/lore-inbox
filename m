Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262081AbVFHDRZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262081AbVFHDRZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 23:17:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262082AbVFHDQb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 23:16:31 -0400
Received: from animx.eu.org ([216.98.75.249]:50106 "EHLO animx.eu.org")
	by vger.kernel.org with ESMTP id S262081AbVFHDPO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 23:15:14 -0400
Date: Tue, 7 Jun 2005 23:11:01 -0400
From: Wakko Warner <wakko@animx.eu.org>
To: linux-kernel@vger.kernel.org
Subject: Re: kaweth fails to work on 2.6.12-rc[56]
Message-ID: <20050608031101.GA28735@animx.eu.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20050608021140.GA28524@animx.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050608021140.GA28524@animx.eu.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wakko Warner wrote:
> Seems that it is unable to send packets however I can see packets coming in.
> I downgraded to 2.6.12-rc2 which works.
> 
> I have not tested rc3 or rc4 yet.  I am preparing to try rc4.

Just finished testing.
rc2 works
rc3 works (fails on aic7xxx with my scsi hardware but rc5 works with my
	scsi hardware)
rc4 through rc6 do not work.

I am currently running on 2.6.12-rc2

> Device ID: 0846:1001
> 
> Info from /sys:
> bConfigurationValue: 1
> bDeviceClass: 00
> bDeviceProtocol: 00
> bDeviceSubClass: 00
> bMaxPower:  90mA
> bNumConfigurations: 1
> bNumInterfaces:  1
> bcdDevice: 0202
> bmAttributes: 80
> configuration: detach_state: 0
> devnum: 8
> idProduct: 1001
> idVendor: 0846
> manufacturer: NETGEAR
> maxchild: 0
> product: NETGEAR EA101 USB Ethernet Adapter
> speed: 12
> version:  1.00
> 
> 
> -- 
>  Lab tests show that use of micro$oft causes cancer in lab animals
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
