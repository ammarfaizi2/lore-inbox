Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965106AbVHJN2x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965106AbVHJN2x (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 09:28:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965108AbVHJN2x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 09:28:53 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:28127 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S965106AbVHJN2w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 09:28:52 -0400
Date: Wed, 10 Aug 2005 06:28:37 -0700 (PDT)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
cc: Geert Uytterhoeven <geert@linux-m68k.org>,
       Linus Torvalds <torvalds@osdl.org>, kiran@scalex86.org,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Fix ide-disk.c oops caused by hwif == NULL
In-Reply-To: <58cb370e050810061342fcd09a@mail.gmail.com>
Message-ID: <Pine.LNX.4.62.0508100626420.12307@schroedinger.engr.sgi.com>
References: <200508100459.j7A4xTn7016128@hera.kernel.org> 
 <Pine.LNX.4.62.0508101310300.18940@numbat.sonytel.be> 
 <Pine.LNX.4.62.0508100604020.12126@schroedinger.engr.sgi.com>
 <58cb370e050810061342fcd09a@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Aug 2005, Bartlomiej Zolnierkiewicz wrote:

> hwif can't be NULL or something is *really* wrong

Ahh.. Yes.... Not enough time to think about this email properly since I 
need to get to the LWCE in SF. Wrong description. The oops was caused by 
pci_dev being NULL..
