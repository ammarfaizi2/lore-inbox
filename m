Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261323AbTFKQjD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 12:39:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262813AbTFKQjD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 12:39:03 -0400
Received: from holomorphy.com ([66.224.33.161]:15329 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S261323AbTFKQjB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 12:39:01 -0400
Date: Wed, 11 Jun 2003 09:52:38 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>
Cc: "'Mika Penttil?'" <mika.penttila@kolumbus.fi>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2][2.5]Unisys ES7000 platform subarch
Message-ID: <20030611165238.GF26348@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>,
	'Mika Penttil?' <mika.penttila@kolumbus.fi>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <3FAD1088D4556046AEC48D80B47B478C022BDA78@usslc-exch-4.slc.unisys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FAD1088D4556046AEC48D80B47B478C022BDA78@usslc-exch-4.slc.unisys.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 11, 2003 at 11:40:05AM -0500, Protasevich, Natalie wrote:
> Clustering on ES7000 follows Intel guidelines, but not quite fall into
> certain cluster model category. According to Intel book, cluster can be flat
> (on the same bus) or hierarchical (physically separate bus segments). Flat
> cluster uses serial bus messaging (like on xAPIC systems) and can support 15
> agents. On both APIC models that ES7000 utilizes, it can support 32
> processors (with xAPICs, 64 hypothreaded P4's, if only OS could support
> that). It has special arrangement for the APIC buses and corresponding
> numbering for APICs, which reflects its topological nature, so the
> conventional APIC cluster numbering schema won't work. Due to those
> differences, our clusters are not that "flat", and we call it "physical",
> and "logical" really means "hierarchical". I think, our cluster model names
> came from some previous distributions that implemented both models, I swear
> I didn't invent it myself. They just worked for our case.

This nomenclature has also been used by other large i386 system vendors
besides Unisys, e.g. Sequent.


-- wli
