Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313445AbSDESqX>; Fri, 5 Apr 2002 13:46:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313311AbSDESqN>; Fri, 5 Apr 2002 13:46:13 -0500
Received: from bitsorcery.com ([161.58.175.48]:58894 "EHLO bitsorcery.com")
	by vger.kernel.org with ESMTP id <S313445AbSDESp7>;
	Fri, 5 Apr 2002 13:45:59 -0500
From: Albert Max Lai <amlai@bitsorcery.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15533.61664.984655.18344@bitsorcery.com>
Date: Fri, 5 Apr 2002 18:45:52 +0000
To: "Marc A. Volovic" <marc@bard.org.il>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.x and DAC960 issues
In-Reply-To: <20020405182731.GA20224@glamis.bard.org.il>
X-Mailer: VM 7.01 under Emacs 20.4.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, 5 April 2002, Marc A. Volovic wrote:

> I am using a Mylex 170LP with no problem, running on a dual 550MHz 
> MSI 6120S under quite a few 2.4.x kernels, lately 2.4.18 and 2.4.19pre5,
> all under reiserfs.  The firmware is 6.00-15, carrying 6 9GB disks
> (5 RAID5 + 1 spare).
> 
> There have been NO lockups under any version of the kernel, not under 
> multiple bonnie runs.
> 
> What is your interrupt breakdown? Could your machine be doing something
> naughty with the interrupts?

This what /proc/interrupts says:
           CPU0       CPU1       
  0:    3874524          0          XT-PIC  timer
  1:      18836          0          XT-PIC  keyboard
  2:          0          0          XT-PIC  cascade
  4:          4          0          XT-PIC  serial
  5:      46479          0          XT-PIC  soundblaster
  8:     218807          0          XT-PIC  rtc
  9:     128424          0          XT-PIC  aic7xxx, aic7xxx
 10:      52035          0          XT-PIC  Mylex DAC1164P
 12:     342261          0          XT-PIC  PS/2 Mouse
 14:     209669          0          XT-PIC  eth0
 15:      44772          0          XT-PIC  eth1, usb-uhci
NMI:          0          0 
LOC:    3874766    3874768 
ERR:         16
MIS:          0

-Albert
