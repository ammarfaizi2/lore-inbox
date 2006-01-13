Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422995AbWAMV77@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422995AbWAMV77 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 16:59:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422996AbWAMV77
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 16:59:59 -0500
Received: from gate.crashing.org ([63.228.1.57]:55433 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1422995AbWAMV76 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 16:59:58 -0500
Subject: Re: 2.6.15-mm3
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Sachin Sant <sachinp@in.ibm.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20060113035229.0560a5dd.akpm@osdl.org>
References: <20060111042135.24faf878.akpm@osdl.org>
	 <43C76623.7060906@in.ibm.com>  <20060113035229.0560a5dd.akpm@osdl.org>
Content-Type: text/plain
Date: Sat, 14 Jan 2006 08:59:38 +1100
Message-Id: <1137189579.4854.17.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > 
> > Problem seems to be because of the following in 
> > include/asm-powerpc/cputable.h
> > 
> > enum powerpc_oprofile_type {
> >          INVALID = 0,
> >          RS64 = 1,
> >          POWER4 = 2,
> >          G4 = 3,     <====Defined here
> >          BOOKE = 4,
> > };
> > 
> 
> err, Ben.  Not a great choice of identifier...

Very bad indeed, /me blames whoever did that oprofile support... I'll
get that fixed asap.

Ben.


