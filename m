Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132022AbRBQXTZ>; Sat, 17 Feb 2001 18:19:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132142AbRBQXTQ>; Sat, 17 Feb 2001 18:19:16 -0500
Received: from landsberger.com ([64.6.193.137]:61197 "EHLO
	mephistopheles.landsberger.com") by vger.kernel.org with ESMTP
	id <S132022AbRBQXTE>; Sat, 17 Feb 2001 18:19:04 -0500
Message-ID: <3A8F077B.169063A8@landsberger.com>
Date: Sat, 17 Feb 2001 15:21:31 -0800
From: Landsberger Brian J <brian@landsberger.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: usb audio
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Has anyone been able to get the Apple Pro (the round clear) speakers to
work in Linux? I've read the howto's and followed the various steps to
no avail. The various usb modules print the following to syslog:


Feb 17 14:05:50 fux0r kernel: usb.c: registered new driver audio
Feb 17 14:05:51 fux0r kernel: usbaudio: device 4 audiocontrol interface
0 has 0 input and 1 output AudioStreaming interfaces
Feb 17 14:05:51 fux0r kernel: usbaudio: device 4 interface 1 altsetting
0 does not have an endpoint
Feb 17 14:05:51 fux0r kernel: usbaudio: device 4 interface 1 altsetting
1: format 0x00000010 sratelo 5000 sratehi 50000 attributes 0x00
Feb 17 14:05:51 fux0r kernel: usbaudio: device 4 interface 1 altsetting
2: format 0x80000010 sratelo 5000 sratehi 50000 attributes 0x00
Feb 17 14:05:51 fux0r kernel: usbaudio: device 4 interface 1 altsetting
3 unsupported channels 2 framesize 3
Feb 17 14:05:51 fux0r kernel: usbaudio: constructing mixer for Terminal
3 type 0x0301

Some info out of usbdevfs on the speakers...

Speakers
Manufacturer: Apple Computer, Inc.
Serial Number: p4000
Speed: 12Mb/s (full)
USB Version:  1.10
Device Class: 00(>ifc )
Device Subclass: 00
Device Protocol: 00
Maximum Default Endpoint Size: 8
Number of Configurations: 1
Vendor Id: 05ac
Product Id: 1101
Revision Number:  0.01

Config Number: 1
	Number of Interfaces: 3
	Attributes: 80
	MaxPower Needed: 500mA

	Interface Number: 0
		Name: audio
		Alternate Number: 0
		Class: 01(audio) 
		Sub Class: 1
		Protocol: 0
		Number of Endpoints: 0

	Interface Number: 1
		Name: audio
		Alternate Number: 0
		Class: 01(audio) 
		Sub Class: 2
		Protocol: 0
		Number of Endpoints: 0

	Interface Number: 1
		Name: audio
		Alternate Number: 1
		Class: 01(audio) 
		Sub Class: 2
		Protocol: 0
		Number of Endpoints: 1

			Endpoint Address: 01
			Direction: out
			Attribute: 9
			Type: Isoc
			Max Packet Size: 112
			Interval:   1ms

	Interface Number: 1
		Name: audio
		Alternate Number: 2
		Class: 01(audio) 
		Sub Class: 2
		Protocol: 0
		Number of Endpoints: 1

			Endpoint Address: 01
			Direction: out
			Attribute: 9
			Type: Isoc
			Max Packet Size: 224
			Interval:   1ms

	Interface Number: 1
		Name: audio
		Alternate Number: 3
		Class: 01(audio) 
		Sub Class: 2
		Protocol: 0
		Number of Endpoints: 1

			Endpoint Address: 01
			Direction: out
			Attribute: 9
			Type: Isoc
			Max Packet Size: 336
			Interval:   1ms

	Interface Number: 2
		Name: hid
		Alternate Number: 0
		Class: 03(HID  ) 
		Sub Class: 0
		Protocol: 0
		Number of Endpoints: 1

			Endpoint Address: 83
			Direction: in
			Attribute: 3
			Type: Int.
			Max Packet Size: 2
			Interval:   8ms

Thanks,
Brian
