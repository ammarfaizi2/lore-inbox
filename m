Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261329AbUJWXDg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261329AbUJWXDg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 19:03:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261330AbUJWXDg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 19:03:36 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:15081 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S261329AbUJWXDb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 19:03:31 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-mm1: NForce3 problem (IRQ sharing issue?)
Date: Sun, 24 Oct 2004 01:05:26 +0200
User-Agent: KMail/1.6.2
Cc: Allan Sandfeld Jensen <allan@carewolf.com>
References: <200410222354.44563.rjw@sisk.pl> <200410240014.47507.allan@carewolf.com>
In-Reply-To: <200410240014.47507.allan@carewolf.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Message-Id: <200410240105.26642.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 24 of October 2004 00:14, Allan Sandfeld Jensen wrote:
> On Friday 22 October 2004 23:54, you wrote:
> > Hi,
> >
> > I have a problem with 2.6.9-mm1 on an AMD64 NForce3-based box.  Namely,
> > after some time in X, USB suddenly stops working and sound goes off
> > simultaneously (it's quite annoying, as I use a USB mouse ;-)).  It is 
100%
> > reproducible and it may be related to the sharing of IRQ 5:
> >
> Have you tried disabling ioapic? 

In principle I could, but I have no such problems with the 2.6.9 kernel, 
although the APIC etc., settings are the same.  Which means there's a 
regression and that's the real issue.

Greets,
RJW

-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
