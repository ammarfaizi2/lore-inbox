Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261340AbVALTRQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261340AbVALTRQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 14:17:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261332AbVALTNR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 14:13:17 -0500
Received: from lucidpixels.com ([66.45.37.187]:1154 "HELO lucidpixels.com")
	by vger.kernel.org with SMTP id S261325AbVALTMR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 14:12:17 -0500
Date: Wed, 12 Jan 2005 14:12:14 -0500 (EST)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p500
To: linux-kernel@vger.kernel.org
Subject: Question regarding ERR in /proc/interrupts.
Message-ID: <Pine.LNX.4.61.0501121410360.11524@p500>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is there anyway to log each ERR to a file or way to find out what caused 
each ERR?

For example, I know this is the cause of a few of them:
spurious 8259A interrupt: IRQ7.

But not all 20, is there any available option to do this?

$ cat /proc/interrupts
            CPU0
   0:  887759057          XT-PIC  timer
   1:       3138          XT-PIC  i8042
   2:          0          XT-PIC  cascade
   5:       5811          XT-PIC  Crystal audio controller
   9:  265081861          XT-PIC  ide4, eth1, eth2
  10:    9087912          XT-PIC  ide6, ide7
  11:     837707          XT-PIC  ide2, ide3
  12:      13854          XT-PIC  i8042
  14:   63373075          XT-PIC  eth0
NMI:          0
ERR:         20

