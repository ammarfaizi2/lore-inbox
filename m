Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267402AbSLLB6k>; Wed, 11 Dec 2002 20:58:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267404AbSLLB6k>; Wed, 11 Dec 2002 20:58:40 -0500
Received: from smtp3.us.dell.com ([143.166.148.134]:31504 "EHLO
	smtp3.us.dell.com") by vger.kernel.org with ESMTP
	id <S267402AbSLLB6j>; Wed, 11 Dec 2002 20:58:39 -0500
Date: Wed, 11 Dec 2002 20:06:21 -0600 (CST)
From: Matt Domsch <Matt_Domsch@Dell.com>
X-X-Sender: mdomsch@humbolt.us.dell.com
Reply-To: Matt Domsch <Matt_Domsch@Dell.com>
To: Greg KH <greg@kroah.com>
cc: marcelo@conectiva.com.br, <linux-kernel@vger.kernel.org>
Subject: Re: [BK PATCH] Dynamic MP_BUSSES and IRQ_SOURCES for 2.4.21-pre1
In-Reply-To: <20021212015326.GI16615@kroah.com>
Message-ID: <20BF5713E14D5B48AA289F72BD372D6802113844-100000@AUSXMPC122.aus.amer.dell.com>
X-GPG-Fingerprint: 17A4 17D0 81F5 4B5F DB1C  AEF8 21AB EEF7 92F0 FC09
X-GPG-Key: http://domsch.com/mdomsch_pub.asc
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The first patch fixes a problem for machines that have more busses or
> irq sources than MAX_MP_BUSSES or MAX_IRQ_SOURCES has been set to.
> time.

Thanks Greg, indeed this is required for our PowerEdge 6600 system also, 
when one adds PCI cards with PCI bridges (dual-port NICs, RAID cards, 
etc).

> This patch was originally written by James Cleverdon, and has been in
> the -ac tree for quite some time.  I also think Red Hat includes it in
> their main kernel, but am not sure.

Yes, Red Hat kernels > 2.4.7-10 and >= 2.4.9-e.3 include this.

Thanks,
Matt

-- 
Matt Domsch
Sr. Software Engineer, Lead Engineer, Architect
Dell Linux Solutions www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com


