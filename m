Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263146AbUC2VrI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 16:47:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263147AbUC2VrI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 16:47:08 -0500
Received: from prime.hereintown.net ([141.157.132.3]:61080 "EHLO
	prime.hereintown.net") by vger.kernel.org with ESMTP
	id S263146AbUC2VrF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 16:47:05 -0500
Subject: Re: older kernels + new glibc?
From: Chris Meadors <clubneon@hereintown.net>
To: Lev Lvovsky <lists1@sonous.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <D8E351AF-81C8-11D8-A0A8-000A959DCC8C@sonous.com>
References: <5516F046-81C1-11D8-A0A8-000A959DCC8C@sonous.com>
	 <1080594005.3570.12.camel@laptop.fenrus.com>
	 <50DC82B4-81C5-11D8-A0A8-000A959DCC8C@sonous.com>
	 <1080595343.3570.15.camel@laptop.fenrus.com>
	 <ACFAE876-81C7-11D8-A0A8-000A959DCC8C@sonous.com>
	 <20040329212832.GB26854@devserv.devel.redhat.com>
	 <D8E351AF-81C8-11D8-A0A8-000A959DCC8C@sonous.com>
Content-Type: text/plain
Message-Id: <1080596719.229.19.camel@clubneon.priv.hereintown.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.5.5 
Date: Mon, 29 Mar 2004 16:45:19 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-03-29 at 13:34 -0800, Lev Lvovsky wrote:

> ok, so this presents a bit of a problem in that case (assuming I'm 
> understanding you) - I'm working backwards in this respect, as I'm 
> using the "new" version of glibc, and an older version of the kernel 
> than the one that glibc was told to remain compatible with - the 
> important question, is does this order of operations (possibly) break 
> things, or does the fact that I compiled the kernel on this new version 
> of glibc remove any issues.

It does not remove any issues.  The kernel doesn't care what libc you
are running, it doesn't make use of the C libraries at all.  But as you
have discovered the libc can be told to care a great deal about the
kernel on which it is running.


-- 
Chris

