Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267091AbUBRW64 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 17:58:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267068AbUBRW6z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 17:58:55 -0500
Received: from hera.kernel.org ([63.209.29.2]:27572 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S267001AbUBRW6D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 17:58:03 -0500
To: linux-kernel@vger.kernel.org
From: hpa@zytor.com (H. Peter Anvin)
Subject: Re: [PATCH] Intel x86-64 support merge
Date: Wed, 18 Feb 2004 22:57:31 +0000 (UTC)
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <c10qkr$gdu$1@terminus.zytor.com>
References: <200402182006.i1IK6CsS022562@hera.kernel.org> <1077139308.4479.8.camel@laptop.fenrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1077145051 16831 63.209.29.3 (18 Feb 2004 22:57:31 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Wed, 18 Feb 2004 22:57:31 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <1077139308.4479.8.camel@laptop.fenrus.com>
By author:    Arjan van de Ven <arjan@fenrus.demon.nl>
In newsgroup: linux.dev.kernel
>
> On Wed, 2004-02-18 at 20:44, Linux Kernel Mailing List wrote:
> 
> > 	The ugliest part is probably the swiotlb code.  In fact the code for
> > 	that is not even included, but just reused from IA64.  swiotlb
> > 	implements the PCI DMA API using bounce buffering.  I don't like this at
> > 	all, but there was no other way to support non DAC capable hardware
> > 	(like IDE or USB) on machines with >3GB.  Please redirect all flames for
> > 	that to the Intel chipset designers.
> 
> ehm... so why on earth did Intel cripple this new platform?????
> 

Because they were caught by surprise and just hacked the chips they
had in the pipeline, presumably.

	-hpa
