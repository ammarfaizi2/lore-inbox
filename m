Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264239AbUDTWKC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264239AbUDTWKC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Apr 2004 18:10:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264277AbUDTWJj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Apr 2004 18:09:39 -0400
Received: from holomorphy.com ([207.189.100.168]:40090 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S264564AbUDTViJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Apr 2004 17:38:09 -0400
Date: Tue, 20 Apr 2004 14:38:03 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Paul Jackson <pj@sgi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: bitmap, cpumask_arith (was: 2.6.6-rc1-mm1)
Message-ID: <20040420213803.GM743@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Paul Jackson <pj@sgi.com>, linux-kernel@vger.kernel.org
References: <20040418230131.285aa8ae.akpm@osdl.org> <20040419062914.GE743@holomorphy.com> <20040418234214.7bfb5392.akpm@osdl.org> <20040419064943.GF743@holomorphy.com> <20040419070643.GG743@holomorphy.com> <20040419113950.6f34f435.pj@sgi.com> <20040420141713.3974e13b.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040420141713.3974e13b.pj@sgi.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 20, 2004 at 02:17:13PM -0700, Paul Jackson wrote:
> I tried making this point before, but failed to communicate.  Let me try
> again.  So far as I know, there is no instance in current Linux kernel
> code using this cpumask facility that is affected (currently broken) by
> the cpumask_arith bugs addressed by Bill's patch.  Do you know of any
> breakage in other _current_ code caused by these cpumask_arith bugs,
> Bill?
> As a consequence of my seeing nothing else yet overtly busted by this,
> it was, and remains, my recommendation to Bill to hold off on these
> patches.  Little sense in correcting the semantics of a piece of code
> that I expected to remove shortly anyway, if nothing else cared for now.
> However, I realize that Bill takes considerable pride in his work, and
> would like to see this fixed.  It's not worth a big fuss, either way,
> so far as I can tell.

I thought you were reporting some instance affected by it. Since there's
no report of anyone affected by it, and a cleanup/whatever pending, I'm
dropping the bugfix patch(es).


-- wli
