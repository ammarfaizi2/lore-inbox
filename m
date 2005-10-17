Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932204AbVJQI1y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932204AbVJQI1y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 04:27:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932211AbVJQI1y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 04:27:54 -0400
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:29657 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932204AbVJQI1x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 04:27:53 -0400
Date: Mon, 17 Oct 2005 04:26:24 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@localhost.localdomain
To: Thomas Gleixner <tglx@linutronix.de>
cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH]  ktimers subsystem 2.6.14-rc2-kt5
In-Reply-To: <20051017075917.GA4827@elte.hu>
Message-ID: <Pine.LNX.4.58.0510170424400.5859@localhost.localdomain>
References: <20050928224419.1.patchmail@tglx.tec.linutronix.de>
 <Pine.LNX.4.61.0509301825290.3728@scrub.home> <1128168344.15115.496.camel@tglx.tec.linutronix.de>
 <Pine.LNX.4.61.0510100213480.3728@scrub.home> <1129016558.1728.285.camel@tglx.tec.linutronix.de>
 <Pine.LNX.4.61.0510130004330.3728@scrub.home> <434DA06C.7050801@mvista.com>
 <Pine.LNX.4.61.0510150143500.1386@scrub.home> <1129490809.1728.874.camel@tglx.tec.linutronix.de>
 <Pine.LNX.4.61.0510170021050.1386@scrub.home> <20051017075917.GA4827@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Trivial "stupid" patch.  MAKE Makefile HAVE -kt($num)!!!!

This will help with ketchup :-)

-- Steve

Index: linux-2.6.14-rc4-kt2/Makefile
===================================================================
--- linux-2.6.14-rc4-kt2.orig/Makefile	2005-10-17 10:14:26.000000000 +0200
+++ linux-2.6.14-rc4-kt2/Makefile	2005-10-17 10:15:12.000000000 +0200
@@ -1,7 +1,7 @@
 VERSION = 2
 PATCHLEVEL = 6
 SUBLEVEL = 14
-EXTRAVERSION =-rc4
+EXTRAVERSION =-rc4-kt2
 NAME=Affluent Albatross

 # *DOCUMENTATION*

