Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262877AbVGHWT7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262877AbVGHWT7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 18:19:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262790AbVGHWSo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 18:18:44 -0400
Received: from adsl-67-120-171-161.dsl.lsan03.pacbell.net ([67.120.171.161]:38845
	"HELO linuxace.com") by vger.kernel.org with SMTP id S262917AbVGHWDK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 18:03:10 -0400
Date: Fri, 8 Jul 2005 15:03:09 -0700
From: Phil Oester <kernel@linuxace.com>
To: Alexander Nyberg <alexn@telia.com>
Cc: Rudo Thomas <rudo@matfyz.cz>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.12.2 -- time passes faster; related to the acpi_register_gsi() call
Message-ID: <20050708220309.GA16413@linuxace.com>
References: <20050708211203.GC382@ss1000.ms.mff.cuni.cz> <1120857908.25294.33.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1120857908.25294.33.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 08, 2005 at 11:25:08PM +0200, Alexander Nyberg wrote:
> fre 2005-07-08 klockan 23:12 +0200 skrev Rudo Thomas:
> > Hello, guys.
> > 
> > Time started to pass faster with 2.6.12.2 (actually, it was 2.6.12-ck3
> > which is based on it). I have isolated the cause of the problem:
> 
> I bet you this fixes it (already in mainline)
> 
> If ACPI doesn't find an irq listed, don't accept 0 as a valid PCI irq.

FYI, this did fix the time-passing-faster problem for me on a poweredge 750
a few days ago.  I'd suggest this fix should go to -stable.

Phil
