Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268072AbUHQBcl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268072AbUHQBcl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 21:32:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268073AbUHQBck
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 21:32:40 -0400
Received: from the-village.bc.nu ([81.2.110.252]:15590 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S268072AbUHQBcb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 21:32:31 -0400
Subject: Re: eth*: transmit timed out since .27
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Oliver Feiler <kiza@gmx.net>
Cc: Len Brown <len.brown@intel.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Marcelo Tosatti <marcelo@hera.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <41213D66.1010909@gmx.net>
References: <566B962EB122634D86E6EE29E83DD808182C3236@hdsmsx403.hd.intel.com>
	 <1092678734.23057.18.camel@dhcppc4> <41210098.4080904@gmx.net>
	 <41210649.4090008@gmx.net> <1092685821.23066.39.camel@dhcppc4>
	 <41213D66.1010909@gmx.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1092702594.21344.6.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 17 Aug 2004 01:29:56 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Looking over the docs the whole ACPI and IOAPIC mode for these boards
seems very different and quite "magic" compared to the PCI mode which is
merely "odd" in a few places. APIC routing bits are stuffed into strange
chipset specific places which implies the quirks probably shouldn't be
applied in acpi mode.

