Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261249AbTG1Js4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 05:48:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263062AbTG1Js4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 05:48:56 -0400
Received: from lidskialf.net ([62.3.233.115]:51416 "EHLO beyond.lidskialf.net")
	by vger.kernel.org with ESMTP id S261249AbTG1Jsz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 05:48:55 -0400
From: Andrew de Quincey <adq_dvb@lidskialf.net>
To: Stefan Cars <stefan@snowfall.se>
Subject: Re: ICH5 SATA high interrupt/system load again...
Date: Mon, 28 Jul 2003 11:04:10 +0100
User-Agent: KMail/1.5.2
References: <20030718233631.F31074@guldivar.globalwire.se> <3F187DB1.1040309@pobox.com> <20030728114850.F22307@guldivar.globalwire.se>
In-Reply-To: <20030728114850.F22307@guldivar.globalwire.se>
Cc: lkml <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307281104.10990.adq_dvb@lidskialf.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 28 July 2003 10:49, Stefan Cars wrote:
> What also is interesting is that when I configure my kernel to use APIC it
> hangs during boot just as it found the SATA drives...

Dunno if it will help, but would you mind giving my latest (final4) ACPI IRQ 
patch a go? It attempts to fix a number of IRQ-related issues.

