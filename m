Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756678AbWKTLRD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756678AbWKTLRD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 06:17:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755909AbWKTLRD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 06:17:03 -0500
Received: from nf-out-0910.google.com ([64.233.182.188]:61262 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1756678AbWKTLRB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 06:17:01 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=aL6vP6zTx8mShaA/8YXWK0YZAm1b7tJC2rFx6OgUcDFp1JC1TZc0mVNItk/mot33GIz0DYu2XK/l1t2/WzRY2g7ZC+kflYKX8g0nVfj9Q8AH+9DMa5uF5uqpOOAhwIeKLJxCNjTfGp8JtIDvVjhk2njnVKMqsawzlByNhqbVJzE=
Message-ID: <8bf247760611200316y761fa18dg4bdfc55e90b70309@mail.gmail.com>
Date: Mon, 20 Nov 2006 16:46:59 +0530
From: Ram <vshrirama@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: USB Mouse does not work, please advice
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
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


Please provide pointers to solve the problem.



Regards,
sriram
