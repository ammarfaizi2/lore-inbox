Return-Path: <linux-kernel-owner+w=401wt.eu-S964931AbWLMFBJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964931AbWLMFBJ (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 00:01:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964934AbWLMFBI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 00:01:08 -0500
Received: from saraswathi.solana.com ([198.99.130.12]:60853 "EHLO
	saraswathi.solana.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964931AbWLMFBH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 00:01:07 -0500
X-Greylist: delayed 2191 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Dec 2006 00:01:07 EST
Date: Tue, 12 Dec 2006 23:18:37 -0500
From: Jeff Dike <jdike@addtoit.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: RFC: UML: remove MODE_TT?
Message-ID: <20061213041837.GA8825@ccure.user-mode-linux.org>
References: <20061212233533.GB28443@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061212233533.GB28443@stusta.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13, 2006 at 12:35:33AM +0100, Adrian Bunk wrote:
> MODE_TT is both marked as deprecated and marked as BROKEN.
> 
> Would a patch to remove MODE_TT, always enable MODE_SKAS, and doing all 
> possible cleanups after this be accepted?

Thanks, but not yet.

I've got that queued up in my tree now, waiting for SMP to work.  SMP is 
the one remaining justification for TT mode, so I'll get that in, then remove
MODE_TT and do the associated cleanups.

				Jeff

-- 
Work email - jdike at linux dot intel dot com
