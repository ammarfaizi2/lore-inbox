Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751141AbVJ2OIe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751141AbVJ2OIe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Oct 2005 10:08:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751152AbVJ2OIe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Oct 2005 10:08:34 -0400
Received: from ams-iport-1.cisco.com ([144.254.224.140]:55359 "EHLO
	ams-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S1751141AbVJ2OIe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Oct 2005 10:08:34 -0400
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] missing include in infiniband
X-Message-Flag: Warning: May contain useful information
References: <20051029054603.GA7992@ftp.linux.org.uk>
From: Roland Dreier <rolandd@cisco.com>
Date: Sat, 29 Oct 2005 07:08:25 -0700
In-Reply-To: <20051029054603.GA7992@ftp.linux.org.uk> (Al Viro's message of
 "Sat, 29 Oct 2005 06:46:03 +0100")
Message-ID: <52acgspg9y.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.17 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
X-OriginalArrivalTime: 29 Oct 2005 14:08:27.0035 (UTC) FILETIME=[3B6E56B0:01C5DC92]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    > 	use of IS_ERR/PTR_ERR in infiniband/core/agent.c, without
    > a portable chain of includes pulling err.h (breaks on a bunch of
    > platforms).
    > Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Looks good to me:

Acked-by: Roland Dreier <rolandd@cisco.com>

I guess I still need to a few more cross-compilers to me collection --
none of i386, x86_64, ppc64, ia64, sparc64 or ppc caught this :(.

 - R.
