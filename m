Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317455AbSF1PWW>; Fri, 28 Jun 2002 11:22:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317456AbSF1PWV>; Fri, 28 Jun 2002 11:22:21 -0400
Received: from insgate.stack.nl ([131.155.140.2]:16655 "EHLO skynet.stack.nl")
	by vger.kernel.org with ESMTP id <S317455AbSF1PWU>;
	Fri, 28 Jun 2002 11:22:20 -0400
Date: Fri, 28 Jun 2002 17:24:41 +0200 (CEST)
From: Serge van den Boom <svdb@stack.nl>
To: linux-kernel@vger.kernel.org
Cc: Jeff Dike <jdike@karaya.com>
Subject: Re: On the forgotten ptrace EIP bug (patch included) 
In-Reply-To: <200206241418.g5OEITq04146@karaya.com>
Message-ID: <20020628144639.I51309-100000@toad.stack.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Jun 2002, Jeff Dike wrote:
> svdb@stack.nl said:
> > The patch below should fix these issues. I have tested it on my
> > machine, where it appears to work.
> Make sure UML still runs with your patch.  That was one of the things (and
> maybe the only thing) that showed the orginal patch was broken.
I know of two other programs that broke with the original patch,
ups and ltrace. Both work with the new one.
As for UML, I don't even see anything go wrong when the original patch is
applied. I can immagine something in UML changed in the meantime that
prevents it from triggering the bug, or I might just be looking in the
wrong place. At any rate, I have successfully booted a UML kernel,
with either patch applied to the host system kernel.

Serge



