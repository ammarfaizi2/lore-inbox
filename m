Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932247AbWDGAkx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932247AbWDGAkx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Apr 2006 20:40:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932248AbWDGAkx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Apr 2006 20:40:53 -0400
Received: from saraswathi.solana.com ([198.99.130.12]:48313 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S932247AbWDGAkw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Apr 2006 20:40:52 -0400
Date: Thu, 6 Apr 2006 19:41:45 -0400
From: Jeff Dike <jdike@addtoit.com>
To: Christopher Friesen <cfriesen@nortel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: problem building UML kernel with 2.6.16.1 -- dies when linking vmlinux
Message-ID: <20060406234145.GA6893@ccure.user-mode-linux.org>
References: <443580A4.1020806@nortel.com> <20060406215131.GA6422@ccure.user-mode-linux.org> <4435A0DA.1030606@nortel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4435A0DA.1030606@nortel.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 06, 2006 at 05:14:34PM -0600, Christopher Friesen wrote:
> Checking that ptrace can change system call numbers...OK
> Checking syscall emulation patch for ptrace...missing
> Checking PROT_EXEC mmap in /tmp...OK
> UML running in TT mode
> tracing thread pid = 8963

Well, tt mode is deprecated in favor of skas0 these days, so you'll do
better with CONFIG_MODE_SKAS enabled and CONFIG_MODE_TT disabled.

				Jeff
