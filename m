Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262033AbUKVK2s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262033AbUKVK2s (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 05:28:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262034AbUKVK2s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 05:28:48 -0500
Received: from ozlabs.org ([203.10.76.45]:13520 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262033AbUKVK2l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 05:28:41 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16801.48858.311455.281186@cargo.ozlabs.ibm.com>
Date: Mon, 22 Nov 2004 21:26:34 +1100
From: Paul Mackerras <paulus@samba.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-rc2-mm3
In-Reply-To: <20041121223929.40e038b2.akpm@osdl.org>
References: <20041121223929.40e038b2.akpm@osdl.org>
X-Mailer: VM 7.19 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton writes:

>   If anyone has patches in -mm which they think should go into 2.6.10 please
>   let me know.  (particularly ppc/ppc64).  The v4l patches certainly look like

I think ppc64-fix-compilation-with-recent-toolchains.patch should go
in, and ppc64-remove-the-volatile-from-cpus_in_xmon.patch should too,
since it removes a compile warning and is low risk.

Paul.
