Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319767AbSIMT5U>; Fri, 13 Sep 2002 15:57:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319768AbSIMT5U>; Fri, 13 Sep 2002 15:57:20 -0400
Received: from [198.92.195.114] ([198.92.195.114]:19722 "EHLO meetpoint.home")
	by vger.kernel.org with ESMTP id <S319767AbSIMT5T>;
	Fri, 13 Sep 2002 15:57:19 -0400
Date: Fri, 13 Sep 2002 16:02:16 -0400 (EDT)
From: Ken Ryan <newsryan@leesburg-geeks.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PCI: device 00:00.0 has unknown header type 7f, ignoring.
Message-ID: <Pine.LNX.4.21.0209131558150.25386-100000@meetpoint.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


According to the PCI 2.2 spec, bit 7 indicates a multifunction device
(=0 or single function in your case), bits 6:0 indicate the header
format.  00=normal device (standard layout), 01=PCI-PCI bridge,
02=CardBus bridge, all other values are Reserved.

	Ken Ryan


