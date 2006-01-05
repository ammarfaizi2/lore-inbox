Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751132AbWAEB3r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751132AbWAEB3r (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 20:29:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751124AbWAEB3r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 20:29:47 -0500
Received: from saraswathi.solana.com ([198.99.130.12]:3233 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1751107AbWAEB3q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 20:29:46 -0500
Date: Wed, 4 Jan 2006 21:21:29 -0500
From: Jeff Dike <jdike@addtoit.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [PATCH 4/9] UML - Better diagnostics for broken configs
Message-ID: <20060105022129.GA13183@ccure.user-mode-linux.org>
References: <200601042151.k04LpxbH009237@ccure.user-mode-linux.org> <20060104152433.7304ec75.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060104152433.7304ec75.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 04, 2006 at 03:24:33PM -0800, Andrew Morton wrote:
> Jeff Dike <jdike@addtoit.com> wrote:
> >
> > Produce a compile-time error if both MODE_SKAS and MODE_TT are disabled.
> Is there no sane way to prevent this situation within Kconfig?

I tried.  The best I managed was to get *config to moan about circular
dependencies.

				Jeff
