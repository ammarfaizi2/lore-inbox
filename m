Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932185AbVKESl1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932185AbVKESl1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 13:41:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932195AbVKESl1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 13:41:27 -0500
Received: from havoc.gtf.org ([69.61.125.42]:39082 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S932185AbVKESl0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 13:41:26 -0500
Date: Sat, 5 Nov 2005 13:41:22 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: Jon Masters <jonathan@jonmasters.org>
Cc: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: PATCH: fix-readonly-policy-use-and-floppy-ro-rw-status
Message-ID: <20051105184122.GA30451@havoc.gtf.org>
References: <20051105182728.GB27767@apogee.jonmasters.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051105182728.GB27767@apogee.jonmasters.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 05, 2005 at 06:27:28PM +0000, Jon Masters wrote:
> [PATCH]: This modifies the gendisk and hd_struct structs to replace "policy"
> with "readonly" (as that's the only use for this field). It also introduces a
> new function disk_read_only, which behaves like the corresponding device
> functions do. I've also replaced direct usage of the old policy fields with
> calls to the appropriate function.
> 
> Signed-off-by: Jon Masters <jcm@jonmasters.org>

Please fix your patch format per http://linux.yyz.us/patch-format.html

Notably:

- Using "[PATCH] " not "PATCH: " in subject line.

- Don't repeat "[PATCH]" in text body, this must be manually edited out.

- This is English, not dashish.  Remove the dashes from the
  one-line description found in the subject line.  These must be
  hand-edited out, too.

