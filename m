Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261472AbUKWTCG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261472AbUKWTCG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 14:02:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261394AbUKWRsp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 12:48:45 -0500
Received: from lucidpixels.com ([66.45.37.187]:160 "HELO lucidpixels.com")
	by vger.kernel.org with SMTP id S261351AbUKWR2z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 12:28:55 -0500
Date: Tue, 23 Nov 2004 12:28:54 -0500 (EST)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p500
To: linux-kernel@vger.kernel.org
Subject: tulip question: tulip.o vs de4x5.o
Message-ID: <Pine.LNX.4.61.0411231216470.3740@p500>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Which driver is recommended for a 4 port card?

Each driver works, I have not benchmarked performance with one over the 
other with ttcp yet; however, does anyone have any experience with using 
one over the other? I see the tulip has several options and the de4x5 
seems to be a rather generic driver.

<M>   DECchip Tulip (dc2114x) PCI support
[*]     New bus configuration (EXPERIMENTAL)
[*]     Use PCI shared mem for NIC registers 
[*]     Use NAPI RX polling 
[*]       Use Interrupt Mitigation

vs.

<M>   Generic DECchip & DIGITAL EtherWORKS PCI/EISA

-rw-r--r--  1 root root 55095 2004-11-23 08:37 de4x5.ko
-rw-r--r--  1 root root 53856 2004-11-23 08:37 tulip.ko


Any suggestions?
