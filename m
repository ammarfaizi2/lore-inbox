Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754366AbWKVMTX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754366AbWKVMTX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 07:19:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754368AbWKVMTX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 07:19:23 -0500
Received: from nf-out-0910.google.com ([64.233.182.190]:59790 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1754330AbWKVMTW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 07:19:22 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Mii6MORnf2e3EaLpXcODbX2kXJsJeeTn6JioL+uYlvEy0oUbE3Art1BcNk0h4JSPLUwL1kTxK89QGCXf6mUbiv4GDV603+1Djv3fRGllVKlAwB6NY8bs5DMEA9HCdfmhAvJJSzE4EwbJKz7iYTzGvZ5FbfDdf19pjpNN8rHK0pY=
Message-ID: <8bf247760611220419i1545352cvc3316562b8b53ce0@mail.gmail.com>
Date: Wed, 22 Nov 2006 17:49:21 +0530
From: Ram <vshrirama@gmail.com>
To: "Jiri Slaby" <jirislaby@gmail.com>
Subject: Re: USB Mouse does not work, please advice
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <45619678.5070400@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <8bf247760611200316y761fa18dg4bdfc55e90b70309@mail.gmail.com>
	 <45619678.5070400@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
  Im using Linux 2.6.13 for PXA270.


 I have connected a mouse and the mouse is detected.

 When i do dmesg, i get the

usb 1-1: new low speed USB device using pxa27x-ohci and address 10
DEV: registering device: ID = '1-1'
bus usb: add device 1-1
bound device '1-1' to driver 'usb'
DEV: registering device: ID = '1-1:1.0'
bus usb: add device 1-1:1.0
usb: Matched Device 1-1:1.0 with Driver usbhid
input: USB HID v1.10 Mouse [Logitech Optical USB Mouse] on usb-pxa27x-1
bound device '1-1:1.0' to driver 'usbhid'
usb: Bound Device 1-1:1.0 to Driver usbhid

When i do 'cat /proc/bus/input/devices': I get the message


[root@Linux /]#cat /proc/bus/input/devices
I: Bus=0003 Vendor=046d Product=c001 Version=2010
N: Name="Logitech USB Mouse"
P: Phys=usb-pxa27x-1/input0
H: Handlers= event0
B: EV=7
B: KEY=70000 0 0 0 0 0 0 0 0
B: REL=103


The Handler field has only event0, But my mouse is not working?.


If i do cat /dev/input/event0. Im able to see characters when i move
the mouse, Im also getting interrupts.

However, When i run XfbDev and move the mouse, the 'X' mark at the
centre does not move.


Am i missing something?.

Regards,
sriram
