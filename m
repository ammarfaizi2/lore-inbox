Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319245AbSHNQm4>; Wed, 14 Aug 2002 12:42:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319246AbSHNQm4>; Wed, 14 Aug 2002 12:42:56 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:47777 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S319245AbSHNQmz>; Wed, 14 Aug 2002 12:42:55 -0400
From: Alan Cox <alan@redhat.com>
Message-Id: <200208141646.g7EGkiu10756@devserv.devel.redhat.com>
Subject: Re: Linux 2.4.20-pre2-ac1
To: hch@infradead.org (Christoph Hellwig)
Date: Wed, 14 Aug 2002 12:46:44 -0400 (EDT)
Cc: alan@redhat.com (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <20020814174407.A20146@infradead.org> from "Christoph Hellwig" at Aug 14, 2002 05:44:07 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Wed, Aug 14, 2002 at 12:34:16PM -0400, Alan Cox wrote:
> > o	Merge 2.4.20-pre2
> > 	-	drop change to apic error logging level
> > 	-	drop bogus sign cast in spin_is_locked
> 
> Could you explain your idea of brokenness a little more?
> 
> A <= 0 must happen against a explicitly signed value.

char is signed on the x86. If you rebuild the x86 tree with unsigned char
thats the *LEAST* of your problems and the fact you get a warning is
-a good thing-
