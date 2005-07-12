Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261408AbVGLMwu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261408AbVGLMwu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 08:52:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261417AbVGLMws
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 08:52:48 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:61653 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261408AbVGLMuu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 08:50:50 -0400
Date: Tue, 12 Jul 2005 14:50:45 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: i386: Selectable Frequency of the Timer Interrupt
Message-ID: <Pine.LNX.4.61.0507121448240.5529@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


Vojtech Pavlik @ Tue, 12 Jul 2005 14:10:08 +0200 wrote:
(http://lkml.org/lkml/2005/7/12/122)

>On Mon, Jul 11, 2005 at 05:38:05PM -0700, George Anzinger wrote:
>> HZ  	TICK RATE	jiffie(ns)	second(ns)	 error (ppbillion)
>>  100	 1193180	10000000	1000000000	       0

>The PIT crystal runs at 14.3181818 MHz (CGA dotclock, found on ISA, ...)
>and is divided by 12 to get PIT tick rate
>	14.3181818 MHz / 12 = 1193182 Hz

What exactly is the frequency of the PIT? Many internet resources say 1193180 
(including the original post), some say 1193181, and you say 1193182 Hz.
Which one is correct? (Ignoring temperature for now..)

IMO 1193181 could be, because it matches the almost-magical number 0x1234DD.


Jan Engelhardt
-- 

