Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264099AbTDKCoK (for <rfc822;willy@w.ods.org>); Thu, 10 Apr 2003 22:44:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264157AbTDKCoJ (for <rfc822;linux-kernel-outgoing>);
	Thu, 10 Apr 2003 22:44:09 -0400
Received: from franka.aracnet.com ([216.99.193.44]:37832 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S264099AbTDKCoI (for <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Apr 2003 22:44:08 -0400
Date: Thu, 10 Apr 2003 19:55:46 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 574] New: Toshiba Satellite - Intel 82801CA sound distortion since k. 2.5.66
Message-ID: <217170000.1050029746@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=574

           Summary: Toshiba Satellite - Intel 82801CA sound distortion since
                    k. 2.5.66
    Kernel Version: 2.5.66 and 2.5.67
            Status: NEW
          Severity: normal
             Owner: bugme-janitors@lists.osdl.org
         Submitter: azote@slinux.net


Distribution:Gentoo
Hardware Environment:Toshiba Satellite 5205-S703
Software Environment:all
Problem Description: Alsa sound driver will make distortions after 3min of
playing any music or video.

 ICH - Intel 82801CA-ICH3
                     Intel 82801CA-ICH3 at 0x1000, irq 11

In the kernel 2.5.65 the sound works great ! but since 2.5.66 looks like it
works ok but after some time of playing it .. starts distortioning...




Steps to reproduce: just play any sound for more time than 4 min ;)

I dont know if this will help but :

 cat /proc/interrupts 
           CPU0       
  0:   24260113          XT-PIC  timer
  1:       3024          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  4:          0          XT-PIC  ohci-hcd
  5:     768368          XT-PIC  nvidia
  6:      62490          XT-PIC  ohci-hcd
  8:          2          XT-PIC  rtc
  9:       1387          XT-PIC  acpi
 10:          0          XT-PIC  Toshiba America Info ToPIC95 PCI to Cardb
 11:    4927788          XT-PIC  Texas Instruments PCI1410 PC card Card,
ehci-hcd, Intel 82801CA-ICH3, orinoco_cs
 12:         60          XT-PIC  i8042
 14:     187473          XT-PIC  ide0
NMI:          0 
LOC:          0 
ERR:        266
MIS:          0


