Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751955AbWCNBXi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751955AbWCNBXi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 20:23:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751985AbWCNBXi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 20:23:38 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:3470 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751955AbWCNBXh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 20:23:37 -0500
Subject: Re: [patch] Require VM86 with VESA framebuffer
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Adrian Bunk <bunk@stusta.de>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>,
       Arjan van de Ven <arjan@linux.intel.com>,
       Chuck Ebbert <76306.1226@compuserve.com>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Antonino Daplas <adaplas@pol.net>, Andi Kleen <ak@suse.de>,
       Kenneth Parrish <Kenneth.Parrish@familynet-international.net>
In-Reply-To: <20060313221651.GO13973@stusta.de>
References: <200603131159_MC3-1-BA89-78CA@compuserve.com>
	 <4415A586.1010404@linux.intel.com>
	 <200603131358.50374.jbarnes@virtuousgeek.org>
	 <20060313221651.GO13973@stusta.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 14 Mar 2006 01:26:13 +0000
Message-Id: <1142299573.25773.45.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2006-03-13 at 23:16 +0100, Adrian Bunk wrote:
> You can only disable CONFIG_VM86 if you have set CONFIG_EMBEDDED=y.

Or are runnig under Xen or 32bit binaries on 64bit. Either way X can
already handle this if properly configured.

