Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161095AbWBVR2i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161095AbWBVR2i (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 12:28:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030319AbWBVR2i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 12:28:38 -0500
Received: from ns2.suse.de ([195.135.220.15]:40161 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030318AbWBVR2h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 12:28:37 -0500
To: prasanna@in.ibm.com
Cc: bibo.mao@intel.com, hiramatu@sdl.hitachi.co.jp,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Kprobes causes NX protection fault on i686 SMP
References: <20060222042121.GA18108@in.ibm.com>
From: Andi Kleen <ak@suse.de>
Date: 22 Feb 2006 18:28:33 +0100
In-Reply-To: <20060222042121.GA18108@in.ibm.com>
Message-ID: <p73u0ar2tha.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Prasanna S Panchamukhi <prasanna@in.ibm.com> writes:

> This patch fixes the problem seen on i686 machine with NX support,
> where the instruction could not be single stepped because of NX
> bit set on the memory pages allocated by kprobes module. This patch
> provides allocation of instruction solt so that the processor can
> execute the instruction from that location similar to x86_64
> architecture. Thanks to Bibo and Masami for testing this patch.
> 
> Signed-off-by: Prasanna S Panchamukhi <prasanna@in.ibm.com>

Looks good to me.

Acked-by: Andi Kleen <ak@suse.de>

-Andi
