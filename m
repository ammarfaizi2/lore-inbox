Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266731AbUGUUpD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266731AbUGUUpD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jul 2004 16:45:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266732AbUGUUpD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jul 2004 16:45:03 -0400
Received: from umhlanga.stratnet.net ([12.162.17.40]:55422 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S266731AbUGUUpA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jul 2004 16:45:00 -0400
To: "David S. Miller" <davem@redhat.com>
Cc: ultralinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix sparc64 build with CONFIG_COMPAT=n
X-Message-Flag: Warning: May contain useful information
References: <52fz808qwy.fsf@topspin.com>
	<20040720200352.5c17b3f7.davem@redhat.com>
From: Roland Dreier <roland@topspin.com>
Date: Wed, 21 Jul 2004 13:43:53 -0700
In-Reply-To: <20040720200352.5c17b3f7.davem@redhat.com> (David S. Miller's
 message of "Tue, 20 Jul 2004 20:03:52 -0700")
Message-ID: <52llhd2ira.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 21 Jul 2004 20:43:53.0186 (UTC) FILETIME=[6F3BEC20:01C46F63]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    David> I like the big fix, and it allowed some cleanups too.  I've
    David> munged your patch a bit and this is what I'm currently
    David> testing.

Cool, my allnoconfig compile tests thank you.

Just out of curiousity, is there any practical use for sparc64 without
CONFIG_COMPAT?  My impression was that everyone used 32-bit userspace
(except for possibly a few executables).

 - R.
