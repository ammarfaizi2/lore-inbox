Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750984AbWFNT2f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750984AbWFNT2f (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 15:28:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751012AbWFNT2f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 15:28:35 -0400
Received: from rhlx01.fht-esslingen.de ([129.143.116.10]:30890 "EHLO
	rhlx01.fht-esslingen.de") by vger.kernel.org with ESMTP
	id S1750984AbWFNT2e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 15:28:34 -0400
Date: Wed, 14 Jun 2006 21:28:33 +0200
From: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
To: Arjan van de Ven <arjan@linux.intel.com>
Cc: Andrew Morton <akpm@osdl.org>, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -mm] i386 syscall opcode reordering (pipelining)
Message-ID: <20060614192833.GA19938@rhlx01.fht-esslingen.de>
References: <20060613195446.GD24167@rhlx01.fht-esslingen.de> <448F1B97.3070207@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <448F1B97.3070207@linux.intel.com>
User-Agent: Mutt/1.4.2.1i
X-Priority: none
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jun 13, 2006 at 01:09:59PM -0700, Arjan van de Ven wrote:
> Andreas Mohr wrote:
> >Hi all,
> >
> >I'd guess that this version features improved pipeline parallelism,
> >since we isolate competing %ebx accesses (_syscall4()) and
> >stack push operations (_syscall5()), right?
> 
> is anybody actually EVER using those???
> I would think not....

In that case... consider the patch dumped ;)

Andreas Mohr
