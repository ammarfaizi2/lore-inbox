Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261786AbVCOU0R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261786AbVCOU0R (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 15:26:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261874AbVCOU0C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 15:26:02 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:8143 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261867AbVCOUWm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 15:22:42 -0500
Subject: Re: enabling IOAPIC on C3 processor?
From: Lee Revell <rlrevell@joe-job.com>
To: jerome lacoste <jerome.lacoste@gmail.com>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <5a2cf1f6050315040956a512a6@mail.gmail.com>
References: <5a2cf1f6050315040956a512a6@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 15 Mar 2005 15:22:36 -0500
Message-Id: <1110918157.17931.18.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-03-15 at 13:09 +0100, jerome lacoste wrote:
> I have a VIA Epia M10000 board that crashes very badly (and pretty
> often, especially when using DMA). I want to fix that.
> 

Are the crashes associated with any particular workload or device?  My
M6000 works perfectly.

The one big problem I had with is is the VIA Unichrome XAA driver had a
FIFO related bug that caused it to stall the PCI bus, delaying
interrupts for tens of ms unless "Option NoAccel" was used.

This bug was fixed over 6 months ago though.

Lee

