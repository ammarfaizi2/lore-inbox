Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263220AbTDVQAB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 12:00:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263225AbTDVQAB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 12:00:01 -0400
Received: from deviant.impure.org.uk ([195.82.120.238]:39098 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S263220AbTDVQAA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 12:00:00 -0400
Date: Tue, 22 Apr 2003 17:11:26 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Andi Kleen <ak@muc.de>
Cc: Arjan van de Ven <arjanv@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Runtime memory barrier patching
Message-ID: <20030422161126.GA13223@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Andi Kleen <ak@muc.de>, Arjan van de Ven <arjanv@redhat.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200304220111.h3M1BEp5004047@hera.kernel.org> <1051001038.1419.3.camel@laptop.fenrus.com> <20030422111832.GC2170@averell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030422111832.GC2170@averell>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 22, 2003 at 01:18:32PM +0200, Andi Kleen wrote:

 > You only need Intel and AMD prefetch. For all Athlons the SSE prefetches
 > work (because we force the SSE MSR bit to on).

Except those before Athlon XP which didn't have SSE.

		Dave

