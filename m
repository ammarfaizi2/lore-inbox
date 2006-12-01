Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759349AbWLAS6m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759349AbWLAS6m (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 13:58:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759350AbWLAS6m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 13:58:42 -0500
Received: from outbound-fra.frontbridge.com ([62.209.45.174]:28209 "EHLO
	outbound2-fra-R.bigfish.com") by vger.kernel.org with ESMTP
	id S1759349AbWLAS6l convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 13:58:41 -0500
X-BigFish: VP
X-Server-Uuid: 519AC16A-9632-469E-B354-112C592D09E8
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: RE: [LinuxBIOS] #57: libusb host program for PLX NET20DC debug
 device
Date: Fri, 1 Dec 2006 10:55:48 -0800
Message-ID: <5986589C150B2F49A46483AC44C7BCA4907276@ssvlexmb2.amd.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [LinuxBIOS] #57: libusb host program for PLX NET20DC debug
 device
Thread-Index: AccVeGOhK39MY0LLQnC/K+FZLWfRKwAAM5Fw
From: "Lu, Yinghai" <yinghai.lu@amd.com>
To: "Greg KH" <gregkh@suse.de>
cc: "Stefan Reinauer" <stepan@coresystems.de>,
       "Peter Stuge" <stuge-linuxbios@cdy.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>, linuxbios@linuxbios.org,
       linux-kernel@vger.kernel.org
X-OriginalArrivalTime: 01 Dec 2006 18:55:49.0571 (UTC)
 FILETIME=[51310930:01C7157A]
X-WSS-ID: 696EA53F0T01891259-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----Original Message-----
From: Greg KH [mailto:gregkh@suse.de] 

>I can do that in about 15 minutes if you give me the device ids for the
>usb debug device that you wish to have.

>Or you can also use the generic usb-serial driver today just fine with
>no modification.  Have you had a problem with using that option?

We are talking about using USB debug device/EHCI debug port in LinuxBIOS
in legacy free PC.
Because one AM2+MCP55 MB doesn't have serial port.

I guess Eric is working on USB debug device/EHCI debug port for
earlyprintk or printk.

So we need one client program on host side. So it would great if we
could use current USB stack for 
the clients on system even without debug port.

I'm getting one USB debug device cable, and will test generic usb_serial
driver.

Thanks

YH



