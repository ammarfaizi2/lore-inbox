Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262228AbTJSVMm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Oct 2003 17:12:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262232AbTJSVMm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Oct 2003 17:12:42 -0400
Received: from sccrmhc13.comcast.net ([204.127.202.64]:29834 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S262228AbTJSVMk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Oct 2003 17:12:40 -0400
Subject: Re: HighPoint 374
From: Joel Smith <joelsmith17@comcast.net>
To: Tomi Orava <Tomi.Orava@ncircle.nullnet.fi>, linux-kernel@vger.kernel.org
In-Reply-To: <41102.192.168.9.10.1066584247.squirrel@ncircle.nullnet.fi>
References: <00b801c3955c$7e623100$0514a8c0@HUSH>
	 <1066579176.7363.3.camel@milo.comcast.net>
	 <41102.192.168.9.10.1066584247.squirrel@ncircle.nullnet.fi>
Content-Type: text/plain
Message-Id: <1066597959.7576.11.camel@milo.comcast.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sun, 19 Oct 2003 14:12:40 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> > In 2.4.21 and 2.4.22 it's working great for me.  I'm using the
> > "experimental" IDE Raid with two disks on a HPT 374 controller with the
> > drivers that come with the kernel.
> 
> I have tried these versions in the past as well without success.
> However, I don't use HPT-raid features at all ie. I'm using the
> disks as JBOD. What hardware do you have and have you enabled
> ACPI/local-apic/io-apic ? What brand & model of disk-drives you
> are using with HPT374 controller ? And finally what does
> the /proc/interrupts show for you ?

The disks are both 80 GB Western Digital 7200RPM/8 MB cache (WD800JB). 
FWIW, the motherboard is an Abit IT7-Max 2 v. 2.0, and I'm currently
using 2.4.22-ck2.  The HPT374 chip is on the motherboard.  I don't have
any ACPI stuff enabled, and I'm not sure what apic is.

Here's my /proc/interrupts:

           CPU0
  0:  490407020          XT-PIC  timer
  1:     160679          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  4:          0          XT-PIC  usb-uhci
  5:   31664356          XT-PIC  eth1, Intel 82801DB-ICH4
  7:   35088687          XT-PIC  usb-uhci, nvidia
  9:          0          XT-PIC  usb-uhci
 11:    1895235          XT-PIC  ide2, ide3
 12:    4340909          XT-PIC  PS/2 Mouse
 15:     117429          XT-PIC  ide1
NMI:          0
ERR:          0

HTH,

Joel Smith

