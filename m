Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266136AbUIJAJC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266136AbUIJAJC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 20:09:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266073AbUIJAG4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 20:06:56 -0400
Received: from 67-41-71-119.roch.qwest.net ([67.41.71.119]:16862 "EHLO
	jdub.homelinux.org") by vger.kernel.org with ESMTP id S267170AbUIJACW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 20:02:22 -0400
Subject: Re: [PATCH Trivial] ppc64:  Use STACK_FRAME_OVERHEAD macro in
	misc.S
From: Josh Boyer <jwboyer@jdub.homelinux.org>
To: Paul Mackerras <paulus@samba.org>
Cc: anton@au.bim.com, linux-kernel@vger.kernel.org
In-Reply-To: <16704.59444.785268.367031@cargo.ozlabs.ibm.com>
References: <1094772116.16444.81.camel@67-41-71-119.roch.qwest.net>
	 <16704.59444.785268.367031@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1094774535.16444.88.camel@67-41-71-119.roch.qwest.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 09 Sep 2004 19:02:16 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-09-09 at 18:33, Paul Mackerras wrote:
> Using STACK_FRAME_OVERHEAD here would be purely arbitrary (i.e. the
> 112 here has no connection with the stack frames established in head.S
> and entry.S).  This function needs a stack frame and 112 bytes is the
> minimum size specified by the ABI.  I think it's quite clear as it is.

Isn't STACK_FRAME_OVERHEAD supposed to mean exactly that, the minimum
stack size?  Or is it just coincidence that the macro is defined to 112?

In any case, I was confused when I originally read it.  If you prefer
112, that's fine by me now that I know what 112 means :).

thx,
josh
