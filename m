Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932357AbWDBA6e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932357AbWDBA6e (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Apr 2006 19:58:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932356AbWDBA6e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Apr 2006 19:58:34 -0500
Received: from ns.ustc.edu.cn ([202.38.64.1]:52866 "EHLO mx1.ustc.edu.cn")
	by vger.kernel.org with ESMTP id S932354AbWDBA6d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Apr 2006 19:58:33 -0500
Date: Sun, 2 Apr 2006 08:58:20 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Andreas Schwab <schwab@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i386 zone_sizes_init() fix
Message-ID: <20060402005820.GA6183@mail.ustc.edu.cn>
Mail-Followup-To: Wu Fengguang <wfg@mail.ustc.edu.cn>,
	Andreas Schwab <schwab@suse.de>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20060401131011.GA10804@mail.ustc.edu.cn> <jeacb5pca8.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jeacb5pca8.fsf@sykes.suse.de>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 01, 2006 at 05:04:47PM +0200, Andreas Schwab wrote:
> Wu Fengguang <wfg@mail.ustc.edu.cn> writes:
> 
> > Now that with MAX_NR_ZONES=4, the last element of zones_size[] is
> > left uninitialized in zone_sizes_init() on i386.
> 
> No, it isn't.  In the presence of an initializer any element not
> explicitly initialized will be set to 0 of the appropriate type.

Got it, thanks for the tip.

Wu
