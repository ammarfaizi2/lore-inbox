Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265656AbTAJRXp>; Fri, 10 Jan 2003 12:23:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265675AbTAJRXp>; Fri, 10 Jan 2003 12:23:45 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:63634
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S265656AbTAJRXo>; Fri, 10 Jan 2003 12:23:44 -0500
Subject: Re: [PATCH]Re: spin_locks without smp.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Maciej Soltysiak <solt@dns.toxicfilms.tv>,
       William Lee Irwin III <wli@holomorphy.com>
In-Reply-To: <3E1F00BB.2090904@colorfullife.com>
References: <3E1F00BB.2090904@colorfullife.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1042222719.32175.9.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-2) 
Date: 10 Jan 2003 18:18:39 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-01-10 at 17:19, Manfred Spraul wrote:
> 
>     disable_irq();
>     spin_lock(&np->lock);
> 
> That's what 8390.c uses, no need for an #ifdef.

Does someone have a card they can test that on. If so then I agree
entirely it is the best way to go 

