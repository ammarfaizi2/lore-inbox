Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964825AbWGELtp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964825AbWGELtp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 07:49:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964826AbWGELtp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 07:49:45 -0400
Received: from liaag2af.mx.compuserve.com ([149.174.40.157]:60609 "EHLO
	liaag2af.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S964825AbWGELto (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 07:49:44 -0400
Date: Wed, 5 Jul 2006 07:44:52 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [PATCH 2/2] i386 TIF flags for debug regs and io bitmap
  in ctxsw
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Stephane Eranian <eranian@hpl.hp.com>
Message-ID: <200607050745_MC3-1-C42B-9936@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <200607042347.00598.ak@suse.de>

On Tue, 4 Jul 2006 23:47:00 +0200, Andi Kleen wrote:

> > I get a 5-10% speedup in task switch times with this patch.
>
> That sounds too much. How did you measure it?
>
> Note that lmbench tends to be unstable for this.

I used lmbench's lat_ctx(8).  According to its manpage, you can make
multiple runs and use the minimum, not the average.

And the gain may have been high because I tested on an old PII notebook
with small cache and slow memory.

-- 
Chuck
 "You can't read a newspaper if you can't read."  --George W. Bush
