Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268149AbUJJHBk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268149AbUJJHBk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Oct 2004 03:01:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268156AbUJJHBk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Oct 2004 03:01:40 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:19620 "EHLO
	pd3mo2so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S268149AbUJJHBh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Oct 2004 03:01:37 -0400
Date: Sun, 10 Oct 2004 01:00:38 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Oops on reboot, FC3 test kernel (based on 2.6.9bk)
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <000501c4ae96$d96fd990$6601a8c0@northbrook>
MIME-version: 1.0
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
X-Mailer: Microsoft Outlook Express 6.00.2900.2180
Content-type: text/plain; reply-type=original; charset=iso-8859-1; format=flowed
Content-transfer-encoding: 7bit
X-Priority: 3
X-MSMail-priority: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On the last couple of Fedora Core 3 test kernels that have been released, 
most recently 2.6.8.1-603 (which I believe is based on 2.6.9-rc BK snapshot) 
I have been seeing an oops when rebooting. I built the kernel myself, with 
the standard config except that IOAPIC on uniprocessor was enabled. This is 
on an Asus P4B533 motherboard (Intel 845 chipset).

The scroll-back feature didn't seem to work and it was too late for the oops 
to be logged, but I did take a picture of the visible part of the crash dump 
which can be viewed here:

http://www.roberthancock.com/kerneloops.png

Looks like it happened while disabling the IOAPIC..

