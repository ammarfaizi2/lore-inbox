Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261823AbTHYNHj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 09:07:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261826AbTHYNHj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 09:07:39 -0400
Received: from ls401.hinet.hr ([195.29.150.2]:39656 "EHLO ls401.hinet.hr")
	by vger.kernel.org with ESMTP id S261823AbTHYNHi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 09:07:38 -0400
Date: Mon, 25 Aug 2003 15:07:34 +0200
From: Mario Mikocevic <mario.mikocevic@htnet.hr>
To: Russell King <rmk@arm.linux.org.uk>
Cc: Mario Mikocevic <mario.mikocevic@htnet.hr>, linux-kernel@vger.kernel.org
Subject: Re: OOPS 2.6.0-test4 (almost) repeatable
Message-ID: <20030825130734.GI14801@danielle.hinet.hr>
References: <20030825091846.GA15017@danielle.hinet.hr> <20030825104035.B30952@flint.arm.linux.org.uk> <20030825102504.GC14801@danielle.hinet.hr> <20030825115538.C30952@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20030825115538.C30952@flint.arm.linux.org.uk>; from rmk@arm.linux.org.uk on Pon, Kol 25, 2003 at 12:55:38 +0200
X-Mailer: Balsa 2.0.13
X-Trace: ls401.hinet.hr 1061816855 25061 195.29.148.143 (Mon, 25 Aug 2003 15:07:35 +0200)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2003.08.25 12:55, Russell King wrote:
> Ok so it isn't a BUG().

I suspected ACPI so I tried booting it with :
 acpi=off		no shutdowns, no oops
 pci=noacpi		within seconds as I plug 650+ it shutdowns (tried three times)
 pci=usepirqmask	survives a _lot_ longer (several mins) but as soon as I
			`cardctl insert` -> shutdown

ACPI problem ?

Any hints what to check next ? I'm welcome to patches ..


-- 
Mario Mikocevic (Mozgy)
mozgy at hinet dot hr
It's never too late to have a good childhood!
      The older you are, the better the toys!
My favourite FUBAR ...
