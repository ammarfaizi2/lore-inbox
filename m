Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751435AbWBWToU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751435AbWBWToU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 14:44:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751764AbWBWToU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 14:44:20 -0500
Received: from a222036.upc-a.chello.nl ([62.163.222.36]:31960 "EHLO
	laptopd505.fenrus.org") by vger.kernel.org with ESMTP
	id S1751435AbWBWToT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 14:44:19 -0500
Subject: Re: Patch to reorder functions in the vmlinux to a defined order
From: Arjan van de Ven <arjan@linux.intel.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Rene Herman <rene.herman@keyaccess.nl>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org, akpm@osdl.org, mingo@elte.hu
In-Reply-To: <Pine.LNX.4.64.0602231133110.3771@g5.osdl.org>
References: <1140700758.4672.51.camel@laptopd505.fenrus.org>
	 <1140707358.4672.67.camel@laptopd505.fenrus.org>
	 <200602231700.36333.ak@suse.de>
	 <1140713001.4672.73.camel@laptopd505.fenrus.org>
	 <Pine.LNX.4.64.0602230902230.3771@g5.osdl.org>
	 <43FE0B9A.40209@keyaccess.nl>
	 <Pine.LNX.4.64.0602231133110.3771@g5.osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 23 Feb 2006 20:44:00 +0100
Message-Id: <1140723841.4672.91.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

\
> That's one reason I didn't make it 16MB. A 4MB machine is pretty damn 
> embedded these days (you'd want to enable EMBEDDED just to turn off some 
> other things that make the kernel bigger), but I can imagine that real 
> people run Linux/x86 in 16MB as long as they don't run X.

for PAE it might make sense to just bump it to 16... but then again..
DMA zone pressure in 2.6 is almost gone anyway

