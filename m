Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264663AbUFGOL6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264663AbUFGOL6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 10:11:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264660AbUFGOL6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 10:11:58 -0400
Received: from zork.zork.net ([64.81.246.102]:50560 "EHLO zork.zork.net")
	by vger.kernel.org with ESMTP id S264663AbUFGOKN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 10:10:13 -0400
To: Christoph Hellwig <hch@infradead.org>
Cc: Arjan van de Ven <arjanv@redhat.com>,
       Russell Leighton <russ@elegant-software.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Using getpid() often, another way? [was Re: clone() <->
 getpid() bug in 2.6?]
References: <40C1E6A9.3010307@elegant-software.com>
	<Pine.LNX.4.58.0406051341340.7010@ppc970.osdl.org>
	<40C32A44.6050101@elegant-software.com>
	<40C33A84.4060405@elegant-software.com>
	<1086537490.3041.2.camel@laptop.fenrus.com>
	<40C3AD9E.9070909@elegant-software.com>
	<20040607121300.GB9835@devserv.devel.redhat.com>
	<6uu0xn5vio.fsf@zork.zork.net> <20040607140009.GA21480@infradead.org>
From: Sean Neakums <sneakums@zork.net>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>, Arjan van de Ven
	<arjanv@redhat.com>, Russell Leighton <russ@elegant-software.com>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
Date: Mon, 07 Jun 2004 15:10:08 +0100
In-Reply-To: <20040607140009.GA21480@infradead.org> (Christoph Hellwig's
	message of "Mon, 7 Jun 2004 15:00:09 +0100")
Message-ID: <6upt8b5uin.fsf@zork.zork.net>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: sneakums@zork.net
X-SA-Exim-Scanned: No (on zork.zork.net); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> writes:

> On Mon, Jun 07, 2004 at 02:48:31PM +0100, Sean Neakums wrote:
>> > for example ia64 doesn't have it.
>> 
>> Then what is the sys_clone2 implementation in arch/is64/kernel/entry.S for?
>
> It's clone with a slightly different calling convention.

Ah.  I misintereted Arjan as saying that ia64 didn't have a clone at
all, which would have been pretty wacky.  Sorry for the noise.
