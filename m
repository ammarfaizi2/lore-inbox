Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262174AbTLLVlk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Dec 2003 16:41:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262198AbTLLVlk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Dec 2003 16:41:40 -0500
Received: from outmail.nrtc.org ([204.145.144.17]:62351 "EHLO
	exchange.nrtc.coop") by vger.kernel.org with ESMTP id S262174AbTLLVlh convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Dec 2003 16:41:37 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.6944.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: 2.4.23 is freezing my systems hard after 24-48 hours
Date: Fri, 12 Dec 2003 16:41:36 -0500
Message-ID: <F7F4B5EA9EBD414D8A0091E80389450569D3CD@exchange.nrtc.coop>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.4.23 is freezing my systems hard after 24-48 hours
Thread-Index: AcPA9pTdolNjSNWDQvm+cF0NzXvlnQAAZH3w
From: "Jeremy Kusnetz" <JKusnetz@nrtc.org>
To: "Philippe Troin" <phil@fifi.org>
Cc: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Have you tried running with the NMI watchdog? I cannot run it myself
> because I have to disable APIC support since my motherboard is
> buggy. To do so, try booting with "nmi_watchdog=1" or "nmi_watchdog=2"
> depending on your configuration. Check Documentation/nmi_watchdog.txt
> for details.  Also verify that the NMI oopser works by checking for a
> non-zero NMI count in /proc/interrupts.

Wish I knew about that earlier, unfortunately I've gone back to the 2.4.22 kernel as these are production boxes and I can't afford any more of these outages.  Besides I'm tired of getting paged at 4am :)  I wish I could get my development boxes to have this problem since it's not a big deal if they go down.

What kind of hardware are you running?  These are Compaq DL360 G1 servers.
