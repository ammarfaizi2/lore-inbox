Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932482AbWH1HwH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932482AbWH1HwH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 03:52:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932480AbWH1HwH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 03:52:07 -0400
Received: from mail.suse.de ([195.135.220.2]:53198 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932481AbWH1HwE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 03:52:04 -0400
From: Andi Kleen <ak@suse.de>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 6/7] remove all remaining _syscallX macros
Date: Mon, 28 Aug 2006 09:50:04 +0200
User-Agent: KMail/1.9.3
Cc: linux-arch@vger.kernel.org, Jeff Dike <jdike@addtoit.com>,
       Bjoern Steinbrink <B.Steinbrink@gmx.de>,
       Arjan van de Ven <arjan@infradead.org>,
       Chase Venters <chase.venters@clientec.com>,
       Andrew Morton <akpm@osdl.org>, Russell King <rmk+lkml@arm.linux.org.uk>,
       rusty@rustcorp.com.au, linux-kernel@vger.kernel.org
References: <20060827214734.252316000@klappe.arndb.de> <p73ac5pe2iy.fsf@verdi.suse.de> <200608280941.10965.arnd@arndb.de>
In-Reply-To: <200608280941.10965.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608280950.04441.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 28 August 2006 09:41, Arnd Bergmann wrote:
> On Monday 28 August 2006 09:35, Andi Kleen wrote:
> > I would prefer to keep them on i386/x86-64 at least because
> > a lot of my test programs are using them.
> > 
> Hmm, maybe we should have an asm-generic/unistd.h then
> containing something like

Or just keep the current ones that work fine? 

(some older glibc implementations also get some cases wrong)

-Andi

