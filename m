Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263115AbTCSP3D>; Wed, 19 Mar 2003 10:29:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263116AbTCSP3D>; Wed, 19 Mar 2003 10:29:03 -0500
Received: from mailout07.sul.t-online.com ([194.25.134.83]:51876 "EHLO
	mailout07.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S263115AbTCSP3C>; Wed, 19 Mar 2003 10:29:02 -0500
Date: Wed, 19 Mar 2003 16:39:39 +0100
From: Andi Kleen <ak@muc.de>
To: Keith Owens <kaos@ocs.com.au>
Cc: Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org
Subject: Re: [patch] 2.4.21-pre5 kksymoops for i386/ia64
Message-ID: <20030319153939.GA30899@averell>
References: <30411.1047944506@ocs3.intra.ocs.com.au> <985.1047953904@ocs3.intra.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <985.1047953904@ocs3.intra.ocs.com.au>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 18, 2003 at 03:18:24AM +0100, Keith Owens wrote:
> ps. The 2.5 kallsyms code is incompatible with modutils 2.4,
> backporting the incomplete 2.5 kallsyms would only get debugging
> symbols for the kernel, not for modules.  Changing modutils 2.4 is not
> an option, I will not introduce an incompatible change in the middle of
> a stable kernel series unless there is no choice (e.g. to fix a
> critical bug).

At least for me not working in cross compile setups is a critical bug.
YMMV.

-Andi
