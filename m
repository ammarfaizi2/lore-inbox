Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932118AbVHSDfk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932118AbVHSDfk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 23:35:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932185AbVHSDfk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 23:35:40 -0400
Received: from fsmlabs.com ([168.103.115.128]:50337 "EHLO fsmlabs.com")
	by vger.kernel.org with ESMTP id S932118AbVHSDfX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 23:35:23 -0400
Date: Thu, 18 Aug 2005 21:41:22 -0600 (MDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Andrew Morton <akpm@osdl.org>
cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
       mingo@elte.hu, torvalds@osdl.org
Subject: Re: [PATCH] Mobil Pentium 4 HT and the NMI
In-Reply-To: <20050818202300.254410f4.akpm@osdl.org>
Message-ID: <Pine.LNX.4.61.0508182137290.28588@montezuma.fsmlabs.com>
References: <1124416748.5186.94.camel@localhost.localdomain>
 <20050818202300.254410f4.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Aug 2005, Andrew Morton wrote:

> Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > Hi,
> > 
> > I'm resending this since I don't see it in git yet, and I'm wondering if
> > there is a problem with this patch.  I have a IBM ThinkPad G41 with a
> > Mobile Pentium 4 HT.  Without this patch, the NMI won't be setup.  Is
> > there a reason that if the x86_model is greater than 0x3 it will return.
> > Since my processor has a 0x4 x86_model, I upped it to that. Otherwise my
> > laptop won't be able to use the NMI.
> > 
> 
> Well I was hoping that someone with knowledge of the low-level Intel model
> differences would pipe up, but they all seem to be in hiding.  (Wildly
> bcc's lots of x86 people).

Looks ok to me, they haven't changed the performance counter setup on 
those processors.

Acked-by: Zwane Mwaikambo <zwane@arm.linux.org.uk>
