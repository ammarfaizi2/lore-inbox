Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267558AbUBRVWH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 16:22:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267647AbUBRVWH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 16:22:07 -0500
Received: from node-d-1fcf.a2000.nl ([62.195.31.207]:9348 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP id S267558AbUBRVWF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 16:22:05 -0500
Subject: Re: [PATCH] Intel x86-64 support merge
From: Arjan van de Ven <arjan@fenrus.demon.nl>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200402182006.i1IK6CsS022562@hera.kernel.org>
References: <200402182006.i1IK6CsS022562@hera.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1077139308.4479.8.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Wed, 18 Feb 2004 22:21:48 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-02-18 at 20:44, Linux Kernel Mailing List wrote:

> 	The ugliest part is probably the swiotlb code.  In fact the code for
> 	that is not even included, but just reused from IA64.  swiotlb
> 	implements the PCI DMA API using bounce buffering.  I don't like this at
> 	all, but there was no other way to support non DAC capable hardware
> 	(like IDE or USB) on machines with >3GB.  Please redirect all flames for
> 	that to the Intel chipset designers.

ehm... so why on earth did Intel cripple this new platform?????

