Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261683AbTIOWjQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 18:39:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261684AbTIOWjQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 18:39:16 -0400
Received: from lidskialf.net ([62.3.233.115]:41196 "EHLO beyond.lidskialf.net")
	by vger.kernel.org with ESMTP id S261683AbTIOWjP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 18:39:15 -0400
From: Andrew de Quincey <adq_dvb@lidskialf.net>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>,
       linux-kernel@vger.kernel.org
Subject: Re: ACPI fixes
Date: Mon, 15 Sep 2003 23:37:42 +0100
User-Agent: KMail/1.5.3
Cc: "Brown, Len" <len.brown@intel.com>
References: <Pine.LNX.4.44.0309151824360.2914-100000@logos.cnet>
In-Reply-To: <Pine.LNX.4.44.0309151824360.2914-100000@logos.cnet>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309152337.42851.adq_dvb@lidskialf.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 15 Sep 2003 10:33 pm, Marcelo Tosatti wrote:
> Len,
>
> What about merging this patches in linux-acpi.bkbits.com ?
>
> They seem to be in the ACPI tree for some time now.
>
> ASUS A7V BIOS version 1011 from  blacklist (Eric Valette)
> support non ACPI compliant SCI over-ride  specs (Jun Nakajima)
> Fix ACPI oops on ThinkPad T32/T40 (Shaohua
> Extended IRQ resource type for nForce (Andrew
> Handle BIOS with _CRS that fails (Jun Nakajima)
>
> Andrew, your fallback to PIC mode patch seems to be doing well, right?

I've not had any complaints, apart from that pci=noacpi bug (which is fixed).

> Did you try to get it into the ACPI tree?

I believe it should be in there already.. or if not, the core ACPI guys wanted 
to test it a bit first because it made quite large changes to how IRQs were 
setup.

