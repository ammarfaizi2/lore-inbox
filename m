Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263529AbTICPKl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 11:10:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263566AbTICPKl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 11:10:41 -0400
Received: from lidskialf.net ([62.3.233.115]:8320 "EHLO beyond.lidskialf.net")
	by vger.kernel.org with ESMTP id S263529AbTICPKk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 11:10:40 -0400
From: Andrew de Quincey <adq_dvb@lidskialf.net>
To: Vladimir Lazarenko <vlad@lazarenko.net>,
       Stephan von Krawczynski <skraw@ithnet.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [ACPI] Where do I send APIC victims?
Date: Wed, 3 Sep 2003 17:09:08 +0100
User-Agent: KMail/1.5.3
Cc: rl@hellgate.ch, linux-kernel@vger.kernel.org,
       acpi-devel@lists.sourceforge.net
References: <20030903080852.GA27649@k3.hellgate.ch> <20030903145356.35b9a192.skraw@ithnet.com> <200309031504.03596.vlad@lazarenko.net>
In-Reply-To: <200309031504.03596.vlad@lazarenko.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309031709.08286.adq_dvb@lidskialf.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 03 Sep 2003 2:04 pm, Vladimir Lazarenko wrote:
> On my board, A7V8X, ACPI/APIC works just perfectly with 2.4.22 and KT400
> chipset, 

Does it indeed? Sounds like that BIOS doesn't have the bug! Can you send me 
your /proc/acpi/dsdt so I can see what is different? Be really good if I can 
nick the code out of that for the other boards!

> alas on A7N8X Deluxe board with nForce2 chipsets it causes nasty 
> hangups.
> Machine just simply freezes, no oops, nothing whatsoever.
>
> Disabling APIC solved the problem.

Does it work with ACPI disabled, but APIC enabled?

