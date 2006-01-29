Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751082AbWA2RLM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751082AbWA2RLM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jan 2006 12:11:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751085AbWA2RLM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jan 2006 12:11:12 -0500
Received: from mail.kroah.org ([69.55.234.183]:46241 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751082AbWA2RLK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jan 2006 12:11:10 -0500
Date: Sun, 29 Jan 2006 09:10:47 -0800
From: Greg KH <gregkh@suse.de>
To: Chuck Wolber <chuckw@quantumlinux.com>
Cc: linux-kernel@vger.kernel.org, stable@kernel.org,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, trivial@rustcorp.com.au
Subject: Re: [PATCH] Documentation/stable_kernel_rules.txt: Clarification
Message-ID: <20060129171047.GA10467@suse.de>
References: <Pine.LNX.4.63.0601290032110.7252@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0601290032110.7252@localhost.localdomain>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 29, 2006 at 01:50:16AM -0800, Chuck Wolber wrote:
> 
> This reflects the clarification made on what patches the -stable team 
> accepts. This applies cleanly to the 2.6.16-rc1 kernel.
> 
> Signed-off-by: Chuck Wolber <chuckw@quantumlinux.com>
> ---
> 
> --- a/Documentation/stable_kernel_rules.txt     2006-01-16 23:44:47.000000000 -0800
> +++ b/Documentation/stable_kernel_rules.txt     2006-01-29 01:45:44.000000000 -0800
> @@ -18,6 +18,7 @@
>     whitespace cleanups, etc).
>   - It must be accepted by the relevant subsystem maintainer.
>   - It must follow the Documentation/SubmittingPatches rules.
> + - Patches for any 2.6 stable kernel release will be considered.

No, this isn't true.

People complained that we immediatly abandonded the last stable kernel
when a new one came out, so we said we would take patches for a bit on
the last series if people wanted to send them.

That's all, it's not some confusing thing, and we are very much not
going to accept patches for "any" kernel release.

So no, I'm not going to accept this.

thanks,

greg k-h

> 
> 
>  Procedure for submitting patches to the -stable tree:

-- 
