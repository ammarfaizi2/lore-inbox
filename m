Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946254AbWKJKNn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946254AbWKJKNn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 05:13:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946263AbWKJKNn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 05:13:43 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:54251 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1946254AbWKJKNm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 05:13:42 -0500
Subject: Re: [discuss] Re: 2.6.19-rc4: known unfixed regressions (v3)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andi Kleen <ak@suse.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Adrian Bunk <bunk@stusta.de>,
       Jeff Chua <jeff.chua.linux@gmail.com>, Matthew Wilcox <matthew@wil.cx>,
       Aaron Durbin <adurbin@google.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       gregkh@suse.de, linux-pci@atrey.karlin.mff.cuni.cz
In-Reply-To: <200611100757.00203.ak@suse.de>
References: <Pine.LNX.4.64.0611080056480.12828@silvia.corp.fedex.com>
	 <Pine.LNX.4.64.0611080932320.3667@g5.osdl.org>
	 <Pine.LNX.4.64.0611080951040.3667@g5.osdl.org>
	 <200611100757.00203.ak@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 10 Nov 2006 10:16:18 +0000
Message-Id: <1163153778.7900.17.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Gwe, 2006-11-10 am 07:56 +0100, ysgrifennodd Andi Kleen:
> I'm sure some people will be upset again if we don't use it.
> Perhaps there are really users who want to use the PCI-E error handling
> for example.

And there is now hardware out there which requires accessing PCI-E
configuration spaces. Disabling it for those cases is not a sensible
option t all.

