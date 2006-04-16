Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750790AbWDPSeW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750790AbWDPSeW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Apr 2006 14:34:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750789AbWDPSeW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Apr 2006 14:34:22 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:8370 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750785AbWDPSeV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Apr 2006 14:34:21 -0400
Subject: Re: [RFC: 2.6 patch] net/irda/irias_object.c: remove unused exports
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Arjan van de Ven <arjan@infradead.org>
Cc: jt@hpl.hp.com, Adrian Bunk <bunk@stusta.de>, Samuel.Ortiz@nokia.com,
       netdev@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <1145209616.3809.14.camel@laptopd505.fenrus.org>
References: <20060414114446.GL4162@stusta.de>
	 <20060414164203.GA24146@bougret.hpl.hp.com>
	 <1145209616.3809.14.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sun, 16 Apr 2006 19:37:19 +0100
Message-Id: <1145212639.5656.3.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2006-04-16 at 19:46 +0200, Arjan van de Ven wrote:
> > 	Personally, I don't see what this patch buy us...
> 
> all the unused exports in the kernel together make a binary kernel 100Kb
> bigger. It's a case of a lot of little steps I suppose (each export
> taking like 100 to 150 bytes depending on the size of the function name)


So why are exports taking us 100-150 bytes, not say 20 which is what I'd
expect ?

