Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264728AbUFSVzU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264728AbUFSVzU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jun 2004 17:55:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264731AbUFSVzU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jun 2004 17:55:20 -0400
Received: from holomorphy.com ([207.189.100.168]:52111 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S264728AbUFSVzR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jun 2004 17:55:17 -0400
Date: Sat, 19 Jun 2004 14:55:09 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: mincore on anon mappings
Message-ID: <20040619215509.GU1863@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrea Arcangeli <andrea@suse.de>,
	"David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
References: <20040619162503.GC12019@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040619162503.GC12019@dualathlon.random>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 19, 2004 at 06:25:03PM +0200, Andrea Arcangeli wrote:
> Hi David,
> here a first (untested) attempt to allow mincore on anon vmas too.
> I heard you need this from gcc, right?
> (btw, returning -ENOMEM for anon vmas was pretty bogus, -EINVAL or
> even -ENOSYS would been more correct)

Thanks for cleaning this up. I gave up on fixing mincore after the
nonlinear fixes for it got dropped.


-- wli
