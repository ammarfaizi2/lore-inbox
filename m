Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265285AbSJRRlJ>; Fri, 18 Oct 2002 13:41:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265277AbSJRRjz>; Fri, 18 Oct 2002 13:39:55 -0400
Received: from sentry.gw.tislabs.com ([192.94.214.100]:42464 "EHLO
	sentry.gw.tislabs.com") by vger.kernel.org with ESMTP
	id <S265238AbSJRRjA>; Fri, 18 Oct 2002 13:39:00 -0400
Date: Fri, 18 Oct 2002 13:44:18 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
X-X-Sender: <sds@raven>
To: Russell Coker <russell@coker.com.au>
cc: <linux-kernel@vger.kernel.org>, <linux-security-module@wirex.com>
Subject: Re: [PATCH] remove sys_security
In-Reply-To: <200210181830.28354.russell@coker.com.au>
Message-ID: <Pine.GSO.4.33.0210181333320.9847-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 18 Oct 2002, Russell Coker wrote:

> The only code that we really want to see in the mainline kernel is the hooks
> for permission checks.  Personally I would not mind if no security module
> ever gets included in Linus' source tree.

I'd disagree.  I would like to see selinux included in the mainstream
kernel someday, but I know that selinux needs quite a bit of work
(Christoph says "rewrite") to make it acceptable.  It also doesn't make
much sense to submit selinux until after the remainder of LSM has been
submitted for possible merging and after some level of pruning
and refinement of LSM has occurred.  I would also expect other security
modules, e.g. DTE, to be submitted by their authors eventually.  If there
aren't any in-tree users of LSM, then there is little motivation for the
kernel developers to retain LSM.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




