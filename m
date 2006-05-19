Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751133AbWESNis@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751133AbWESNis (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 May 2006 09:38:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751325AbWESNis
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 May 2006 09:38:48 -0400
Received: from ns0.rackplans.net ([65.39.167.209]:8082 "EHLO mtl.rackplans.net")
	by vger.kernel.org with ESMTP id S1751133AbWESNir (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 May 2006 09:38:47 -0400
Date: Fri, 19 May 2006 09:38:32 -0400 (EDT)
From: Gerhard Mack <gmack@innerfire.net>
X-X-Sender: gmack@mtl.rackplans.net
To: linux-kernel@vger.kernel.org
Subject: linux 2.6.16.16 breaks touchscreens
Message-ID: <Pine.LNX.4.64.0605190932470.16521@mtl.rackplans.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello,

I have a touchscreen device that works on 2.6.14 but breaks on 2.6.16.

The kernel is detecting the device and it is registering in 
/proc/bus/input/devices but not showing up in /dev/input

dmesg:

input: eGalax Inc. USB TouchController as /class/input/input0
usbcore: registered new driver touchkitusb
mice: PS/2 mouse device common for all mice
ts: Compaq touchscreen protocol output

/proc/bus/usb/devices: 
I: Bus=0003 Vendor=0eef Product=0001 Version=0100
N: Name="eGalax Inc. USB TouchController"
P: Phys=/input0
S: Sysfs=/class/input/input0
H: Handlers=mouse0 event0 ts0
B: EV=b
B: KEY=400 0 0 0 0 0 0 0 0 0 0
B: ABS=3

kiosk10:/dev/input# ls -l
total 0
crw-rw----  1 root root 13,  63 2006-05-19 09:06 mice
crw-rw----  1 root root 10, 223 2006-05-19 09:06 uinput



--
Gerhard Mack

gmack@innerfire.net

<>< As a computer I find your faith in technology amusing.
