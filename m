Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271330AbTGXOmV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jul 2003 10:42:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271419AbTGXOmV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jul 2003 10:42:21 -0400
Received: from crosslink-village-512-1.bc.nu ([81.2.110.254]:23288 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S271330AbTGXOmU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jul 2003 10:42:20 -0400
Subject: Re: [uClinux-dev] Kernel 2.6 size increase - get_current()?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: David McCullough <davidm@snapgear.com>
Cc: Bernardo Innocenti <bernie@develer.com>,
       Christoph Hellwig <hch@infradead.org>,
       "David S. Miller" <davem@redhat.com>, uclinux-dev@uclinux.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Greg Ungerer <gerg@snapgear.com>
In-Reply-To: <20030724120441.GC16168@beast>
References: <200307232046.46990.bernie@develer.com>
	 <200307240035.38502.bernie@develer.com>
	 <1058999786.6890.21.camel@dhcp22.swansea.linux.org.uk>
	 <200307240100.00632.bernie@develer.com> <20030724050655.GA11947@beast>
	 <1059046125.7993.11.camel@dhcp22.swansea.linux.org.uk>
	 <20030724120441.GC16168@beast>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1059058118.7998.15.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 24 Jul 2003 15:48:39 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2003-07-24 at 13:04, David McCullough wrote:
> So should the trend be away from inlining,  especially larger functions ?
> 
> I know on m68k some of the really simple inlines are actually smaller as
> an inline than as a function call.  But they have to be very simple,  or
> only used once.

Cool. As to trends well there are two conflicting ones - less inlines but
also more code because of adding fast paths to cut conditions down on normal
sequences of execution.


