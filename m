Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964797AbWH1K7g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964797AbWH1K7g (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 06:59:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964798AbWH1K7g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 06:59:36 -0400
Received: from mx1.suse.de ([195.135.220.2]:34790 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S964797AbWH1K7f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 06:59:35 -0400
From: Andi Kleen <ak@suse.de>
To: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [PATCH 6/7] remove all remaining _syscallX macros
Date: Mon, 28 Aug 2006 12:58:56 +0200
User-Agent: KMail/1.9.3
Cc: David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org,
       rusty@rustcorp.com.au, rmk+lkml@arm.linux.org.uk, akpm@osdl.org,
       chase.venters@clientec.com, B.Steinbrink@gmx.de, jdike@addtoit.com,
       linux-arch@vger.kernel.org, arnd@arndb.de,
       David Miller <davem@davemloft.net>
References: <200608281003.02757.ak@suse.de> <1156759232.5340.36.camel@pmac.infradead.org> <1156761447.3034.178.camel@laptopd505.fenrus.org>
In-Reply-To: <1156761447.3034.178.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608281258.56199.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> the x86_64 macros use the VDSO page? great! I didn't know that.
> But that would make them unusable for kernel use I suspect...

Not sure what you're talking about. x86-64 64bit system calls don't go
through a vDSO

-Andi (who is out of the thread which seems to be full of unconstructive
polemics now)

