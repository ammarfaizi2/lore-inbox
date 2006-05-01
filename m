Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932236AbWEAUhb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932236AbWEAUhb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 16:37:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932237AbWEAUhb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 16:37:31 -0400
Received: from cantor.suse.de ([195.135.220.2]:14749 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932236AbWEAUha (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 16:37:30 -0400
Date: Mon, 1 May 2006 13:35:52 -0700
From: Greg KH <greg@kroah.com>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Andi Kleen <ak@suse.de>,
       linux-stable <stable@kernel.org>
Subject: Re: [stable] [patch 2.6.17-rc3] i386: fix broken FP exception handling
Message-ID: <20060501203552.GC19423@kroah.com>
References: <200604291409_MC3-1-BE50-16AD@compuserve.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200604291409_MC3-1-BE50-16AD@compuserve.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 29, 2006 at 02:07:49PM -0400, Chuck Ebbert wrote:
> The FXSAVE information leak patch introduced a bug in FP exception
> handling: it clears FP exceptions only when there are already
> none outstanding.  Mikael Pettersson reported that causes problems
> with the Erlang runtime and has tested this fix.
> 
> Signed-off-by: Chuck Ebbert <76306.1226@compuserve.com>
> Acked-by: Mikael Pettersson <mikpe@it.uu.se>
> 
> ---
> 
> The same bug is in 2.6.16.9+ and this patch applies there as well.

Thanks, this got included in 2.6.16.12

greg k-h
