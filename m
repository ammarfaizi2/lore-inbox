Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264111AbTEOQqT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 12:46:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264102AbTEOQqR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 12:46:17 -0400
Received: from tom.hrz.tu-chemnitz.de ([134.109.132.38]:59623 "EHLO
	tom.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id S264111AbTEOQo6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 12:44:58 -0400
Date: Thu, 15 May 2003 18:36:31 +0200
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: William Lee Irwin III <wli@holomorphy.com>, gibbs@scsiguy.com,
       linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: ahc_linux_map_seg() compile/style/data corruption fixes
Message-ID: <20030515183631.B626@nightmaster.csn.tu-chemnitz.de>
References: <20030514044934.GC29926@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20030514044934.GC29926@holomorphy.com>; from wli@holomorphy.com on Tue, May 13, 2003 at 09:49:34PM -0700
X-Spam-Score: -5.0 (-----)
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *19GM38-0006BK-00*syA79fdd4CI*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 13, 2003 at 09:49:34PM -0700, William Lee Irwin III wrote:
> (6) uint32_t used instead of u32 (contrary to Linux conventions)

Where is this stated? 

uint32_t is C99 contrary to u32. It's valid
both in user and kernel space and allows to define ABI only once.

I use it both in user space and kernel code.

So I really need a _good_ reason, why this is against the
convention ;-)


Thanks & Regards

Ingo Oeser
