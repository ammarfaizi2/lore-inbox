Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932212AbWGGT6c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932212AbWGGT6c (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 15:58:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932218AbWGGT6c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 15:58:32 -0400
Received: from saraswathi.solana.com ([198.99.130.12]:29136 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S932212AbWGGT6b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 15:58:31 -0400
Date: Fri, 7 Jul 2006 15:58:21 -0400
From: Jeff Dike <jdike@addtoit.com>
To: "Brock, Anthony - NET" <Anthony.Brock@oregonstate.edu>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [uml-devel] [PATCH 19/19] UML - Make mconsole versionrequestshappen in a process
Message-ID: <20060707195821.GA5988@ccure.user-mode-linux.org>
References: <20060707165851.GA5391@ccure.user-mode-linux.org> <7B4268E5ACB878429B58D4BE5B780E83010B6B49@NWS-EXCH2.nws.oregonstate.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7B4268E5ACB878429B58D4BE5B780E83010B6B49@NWS-EXCH2.nws.oregonstate.edu>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 07, 2006 at 10:07:25AM -0700, Brock, Anthony - NET wrote:
> What is the recommended means for verifying that a UML process is
> running?

Depends on what level of "running" you want to check for.  Ping will
tell you if the kernel can respond to interrupts.  mconsole version
(now) will tell you whether it can schedule processes.  mconsole sysrq
is another way to check that it is alive enough to respond to
interrupts.

				Jeff
