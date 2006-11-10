Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946614AbWKJNgZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946614AbWKJNgZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 08:36:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946622AbWKJNgZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 08:36:25 -0500
Received: from zeus1.kernel.org ([204.152.191.4]:482 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1946614AbWKJNgY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 08:36:24 -0500
Date: Fri, 10 Nov 2006 16:35:04 +0300
From: Paul P Komkoff Jr <i@stingr.net>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Dumb question] 100k RTC interrupts/sec on SMP system: why?
Message-ID: <20061110133504.GC18001@stingr.net>
Mail-Followup-To: Arjan van de Ven <arjan@infradead.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20061109100953.GE2226@stingr.net> <20061109204145.56d02153.akpm@osdl.org> <20061110123541.GA18001@stingr.net> <1163163603.3138.700.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <1163163603.3138.700.camel@laptopd505.fenrus.org>
User-Agent: Agent Darien Fawkes
X-Mailer: Intel Ultra ATA Storage Driver
X-RealName: Stingray Greatest Jr
Organization: Department of Fish & Wildlife
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Replying to Arjan van de Ven:
> Also have you tried acpi=off or the linux firmware test kit (see url in

acpi=off fixed this.
  8:          1          0    IO-APIC-edge  rtc

So I got rid of "interrupt storm" but what I've lost (except poweroff)?
-- 
Paul P 'Stingray' Komkoff Jr // http://stingr.net/key <- my pgp key
 This message represents the official view of the voices in my head
