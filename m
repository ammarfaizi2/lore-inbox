Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315483AbSFTTmF>; Thu, 20 Jun 2002 15:42:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315485AbSFTTmE>; Thu, 20 Jun 2002 15:42:04 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:19093 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S315483AbSFTTmD>; Thu, 20 Jun 2002 15:42:03 -0400
From: Alan Cox <alan@redhat.com>
Message-Id: <200206201942.g5KJg3F07150@devserv.devel.redhat.com>
Subject: Re: [PATCH] 2.4-ac: sparc64 support for O(1) scheduler
To: davem@redhat.com (David S. Miller)
Date: Thu, 20 Jun 2002 15:42:03 -0400 (EDT)
Cc: rml@mvista.com, alan@redhat.com, linux-kernel@vger.kernel.org
In-Reply-To: <20020615.062233.123620674.davem@redhat.com> from "David S. Miller" at Jun 15, 2002 06:22:33 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>    them... (I am currently putting together all the scheduler bits we have
>    been working on for a 2.4-ac patch...)
> 
> Your sparc64 kernel/sched.c bits have zero testing in any kernel.
> What point are you trying to make?  It disables a very important
> optimization on SMP sparc64.  It's simply unacceptable.

I don't care about Sparc64, especially as a short term item. Long term
yes you are right but for the -ac work, it can fall back for a while
