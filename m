Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261817AbVAMXrD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261817AbVAMXrD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 18:47:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261810AbVAMXoB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 18:44:01 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:63973 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261817AbVAMXmW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 18:42:22 -0500
Subject: Re: [BUG] ATA over Ethernet __init calling __exit
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andi Kleen <ak@muc.de>
Cc: Ed L Cashin <ecashin@coraid.com>, Jens Axboe <axboe@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       jgarzik@pobox.com
In-Reply-To: <20050113215346.GB1504@muc.de>
References: <20050113000949.A7449@flint.arm.linux.org.uk>
	 <20050113085035.GC2815@suse.de> <m1wtuh2kah.fsf@muc.de>
	 <87is616oi2.fsf@coraid.com>  <20050113215346.GB1504@muc.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1105654178.4624.152.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 13 Jan 2005 22:09:42 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2005-01-13 at 21:53, Andi Kleen wrote:
> > If it ever did become desirable, we could use a couple more bits for
> 
> It likely will if someone ever adds significant write cache to such
> devices.

ATA doesn't support tagged queueing. Therefore write cache is
irrelevant.

Alan

