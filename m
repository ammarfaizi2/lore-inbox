Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261392AbTCOFaO>; Sat, 15 Mar 2003 00:30:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261394AbTCOFaO>; Sat, 15 Mar 2003 00:30:14 -0500
Received: from lucidpixels.com ([66.45.37.187]:18193 "HELO lucidpixels.com")
	by vger.kernel.org with SMTP id <S261392AbTCOFaN>;
	Sat, 15 Mar 2003 00:30:13 -0500
Date: 15 Mar 2003 05:41:00 -0000
Message-ID: <20030315054100.20199.qmail@lucidpixels.com>
From: war@lucidpixels.com
To: adilger@clusterfs.com, war@lucidpixels.com
Subject: Re: Broadcom BCM5702 Major Problems
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Found the bug.
Well, for me anyway.
When I have this configuration option turned on:

[*] IO-APIC support on uniprocessors

Everything goes to hell.

Even the 3COM I stuck in wants to get routed to IRQ 18 and you cannot even force it to use anotheR IRQ.

This option:

[*] Local APIC support on uniprocessors

Works fine.

It is the second option that royally screws over the system.
