Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263596AbUEWVPr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263596AbUEWVPr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 May 2004 17:15:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263600AbUEWVPr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 May 2004 17:15:47 -0400
Received: from holomorphy.com ([207.189.100.168]:8581 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S263596AbUEWVPq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 May 2004 17:15:46 -0400
Date: Sun, 23 May 2004 14:11:54 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Horst von Brand <vonbrand@inf.utfsm.cl>,
       Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.7-rc1
Message-ID: <20040523211154.GC1833@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Jeff Garzik <jgarzik@pobox.com>,
	Horst von Brand <vonbrand@inf.utfsm.cl>,
	Linus Torvalds <torvalds@osdl.org>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200405231619.i4NGJBe18903@pincoya.inf.utfsm.cl> <40B0EE6C.70400@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40B0EE6C.70400@pobox.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 23, 2004 at 02:33:16PM -0400, Jeff Garzik wrote:
> Linux has a tradition of completely rewriting the VM in the middle of a 
> stable series, why not again?  :)
> /me is joking, but similarly annoyed...
> The VM, like the rest of the kernel, will _always_ be a work in 
> progress.  A stable series should freeze us for bug fixing and 
> stabilization...

I wouldn't qualify either of the major VM patch series merged as
rewrites. I saw:
(1) move unmapping function/helpers to different algorithm to save space
(2) NUMA API and support functions

At the risk of trivializing the large amount of work that went into
minimizing the risk of merging these things, the VM hasn't been changed
in any fundamental way by either of them.


-- wli
