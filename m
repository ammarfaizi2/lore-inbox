Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264588AbUFGNsh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264588AbUFGNsh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 09:48:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264623AbUFGNsh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 09:48:37 -0400
Received: from zork.zork.net ([64.81.246.102]:37610 "EHLO zork.zork.net")
	by vger.kernel.org with ESMTP id S264588AbUFGNse (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 09:48:34 -0400
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Russell Leighton <russ@elegant-software.com>,
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
From: Sean Neakums <sneakums@zork.net>
Mail-Followup-To: Arjan van de Ven <arjanv@redhat.com>, Russell Leighton
	<russ@elegant-software.com>, Kernel Mailing List
	<linux-kernel@vger.kernel.org>
Date: Mon, 07 Jun 2004 14:48:31 +0100
In-Reply-To: <20040607121300.GB9835@devserv.devel.redhat.com> (Arjan van de
	Ven's message of "Mon, 7 Jun 2004 14:13:00 +0200")
Message-ID: <6uu0xn5vio.fsf@zork.zork.net>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: sneakums@zork.net
X-SA-Exim-Scanned: No (on zork.zork.net); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven <arjanv@redhat.com> writes:

> On Sun, Jun 06, 2004 at 07:49:50PM -0400, Russell Leighton wrote:
>> Arjan van de Ven wrote:
>> 
>> >Note also that
>> >
>> >clone() is not a portable interface even within linux architectures.
>> >
>> > 
>> >
>> Really???!!! How so?
>
> for example ia64 doesn't have it.

Then what is the sys_clone2 implementation in arch/is64/kernel/entry.S for?

