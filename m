Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262997AbUC2NWC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 08:22:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262987AbUC2NV2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 08:21:28 -0500
Received: from gate.crashing.org ([63.228.1.57]:21651 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262976AbUC2NSt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 08:18:49 -0500
Subject: Re: [PATCH] ppc32: Fix sector_t definition with CONFIG_LBD
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andi Kleen <ak@suse.de>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <p7365co848r.fsf@nielsen.suse.de>
References: <1080541934.1210.5.camel@gaston>
	 <20040328230351.1a0d0e9c.akpm@osdl.org>  <p7365co848r.fsf@nielsen.suse.de>
Content-Type: text/plain
Message-Id: <1080566303.1232.32.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 29 Mar 2004 23:18:23 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>  
> -#ifdef CONFIG_LBD
>  typedef u64 sector_t;
>  #define HAVE_SECTOR_T
> -#endif

Do you need that at all then ? The default unsigned long should
be just fine...

Ben.


