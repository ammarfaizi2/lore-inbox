Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932512AbWB1TlK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932512AbWB1TlK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 14:41:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932475AbWB1TlK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 14:41:10 -0500
Received: from nproxy.gmail.com ([64.233.182.207]:49491 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932512AbWB1TlI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 14:41:08 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=ApAxY/Sev6OrcPcjCSJM6HmVVEwOtF3JBSnadJSRDX3AmB3mDlG30/z2utNyX+RHQ5ikDaz/z+aY49qJOE4ZkMQjtMn1Omke8Lug6WUrxwzlZGkBMLwgxeT5hrbP1m4iRhxQ0bTiHWOHDJaXnXyJYajkze53sAHtH7jDBKeuR20=
Date: Tue, 28 Feb 2006 22:40:50 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: usb usb5: Manufacturer: Linux 2.6.16-rc5-mm1 ehci_hcd
Message-ID: <20060228194050.GA7793@mipter.zuzino.mipt.ru>
References: <20060228042439.43e6ef41.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060228042439.43e6ef41.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lines like the one below puzzle me for a couple -mm's:

usb usb5: new device found, idVendor=0000, idProduct=0000
usb usb5: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb5: Product: EHCI Host Controller
==>	usb usb5: Manufacturer: Linux 2.6.16-rc5-mm1 ehci_hcd	<==
usb usb5: SerialNumber: 0000:00:1d.7
usb usb5: configuration #1 chosen from 1 choice
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 8 ports detected

Is it supposed to contain "Intel" and "Corporation"?

P.S.: 00:1d.7 USB Controller: Intel Corporation 82801EB/ER (ICH5/ICH5R)
      USB2 EHCI Controller (rev 02)

