Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261907AbVD1OjT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261907AbVD1OjT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 10:39:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261962AbVD1OjT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 10:39:19 -0400
Received: from darwin.snarc.org ([81.56.210.228]:26344 "EHLO darwin.snarc.org")
	by vger.kernel.org with ESMTP id S261907AbVD1OjL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 10:39:11 -0400
Date: Thu, 28 Apr 2005 16:39:07 +0200
From: Vincent Hanquez <vincent.hanquez@cl.cam.ac.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: Vincent Hanquez <vincent.hanquez@cl.cam.ac.uk>,
       linux-kernel@vger.kernel.org, ian.pratt@cl.cam.ac.uk
Subject: Re: [PATCH 3/6][XEN][x86] Rename usermode macro
Message-ID: <20050428143907.GA849@snarc.org>
References: <20050426103804.85A7B4BE16@darwin.snarc.org> <20050426112604.GC26614@snarc.org> <20050427194343.3d3ffe2f.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050427194343.3d3ffe2f.akpm@osdl.org>
X-Warning: Email may contain unsmilyfied humor and/or satire.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 27, 2005 at 07:43:43PM -0700, Andrew Morton wrote:
> Why didn't your testing pick up the x86_64 build error?
> 
> arch/x86_64/oprofile/built-in.o(.text+0x1d09): In function `x86_backtrace':
> arch/x86_64/oprofile/../../i386/oprofile/backtrace.c:94: undefined reference to `user_mode_vm'

ouch, sorry about that.

the x86 and x86-64 patches has been compiled separately, which obviously
was a wrong thing to do...
I will do a full test on x86-64 next time I'm doing such thing.

-- 
Vincent Hanquez
