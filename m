Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265945AbUAPXha (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 18:37:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265946AbUAPXha
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 18:37:30 -0500
Received: from ns.suse.de ([195.135.220.2]:37772 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S265945AbUAPXh3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 18:37:29 -0500
Subject: Re: [PATCH 2/2] Default hooks protecting the XATTR_SECURITY_PREFIX
	namespace
From: Andreas Gruenbacher <agruen@suse.de>
To: Chris Wright <chrisw@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org,
       lkml <linux-kernel@vger.kernel.org>, linux-security-module@wirex.com,
       Stephen Smalley <sds@epoch.ncsc.mil>,
       Michael Kerrisk <michael.kerrisk@gmx.net>
In-Reply-To: <20040116132004.R19023@osdlab.pdx.osdl.net>
References: <20040116131423.Q19023@osdlab.pdx.osdl.net>
	 <20040116132004.R19023@osdlab.pdx.osdl.net>
Content-Type: text/plain
Organization: SUSE Labs, SUSE LINUX AG
Message-Id: <1074296264.2679.11.camel@nb.suse.de>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Sat, 17 Jan 2004 00:37:44 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Chris,

the patch looks fine to me. Thank you all for reacting so quickly.

On Fri, 2004-01-16 at 22:20, Chris Wright wrote:
> Add default hooks for both the dummy and capability code to protect the
> XATTR_SECURITY_PREFIX namespace.  These EAs were fully accessible to
> unauthorized users, so a user that rebooted from an SELinux kernel to a
> default kernel would leave those critical EAs unprotected.

Regards,
-- 
Andreas Gruenbacher <agruen@suse.de>
SUSE Labs, SUSE LINUX AG

