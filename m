Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161891AbWI2Tzc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161891AbWI2Tzc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 15:55:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161890AbWI2Tzb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 15:55:31 -0400
Received: from smtp.osdl.org ([65.172.181.4]:15777 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422671AbWI2Tz3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 15:55:29 -0400
Date: Fri, 29 Sep 2006 12:54:11 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: michael@ellerman.id.au, linux-kernel@vger.kernel.org,
       Andi Kleen <ak@muc.de>, Hugh Dickens <hugh@veritas.com>,
       Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH RFC 1/4] Generic BUG handling.
Message-Id: <20060929125411.60bbd0a2.akpm@osdl.org>
In-Reply-To: <451D77A5.20103@goop.org>
References: <20060928225444.439520197@goop.org>
	<20060928225452.229936605@goop.org>
	<1159506427.25820.20.camel@localhost.localdomain>
	<451D77A5.20103@goop.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Sep 2006 12:44:37 -0700
Jeremy Fitzhardinge <jeremy@goop.org> wrote:

> Michael Ellerman wrote:
> > It needed a bit of work to get going on powerpc:
> >
> > Generic BUG handling, Powerpc fixups
> >   
> 
> BTW, powerpc doesn't seem to be using BUG_OPCODE or 
> BUG_ILLEGAL_INSTRUCTION for actual BUGs any more (I presume they were 
> once used).  There are still a couple of uses of those macros elsewhere 
> (kernel/prom_init.c and kernel/head_64.S); should be converted to "twi 
> 31,0,0" as well?
> 

I added that to the changelog.

I'll collapse all the patches I have back into a sane series and I'll send
them back at you, in case you feel inspired to improve them ;)

