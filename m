Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261440AbULNH1i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261440AbULNH1i (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 02:27:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261442AbULNH1i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 02:27:38 -0500
Received: from cantor.suse.de ([195.135.220.2]:30865 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261440AbULNH1h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 02:27:37 -0500
Date: Tue, 14 Dec 2004 08:27:25 +0100
From: Andi Kleen <ak@suse.de>
To: Stephen Degler <stephen@degler.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: NUMA on i386 with Opterons
Message-ID: <20041214072725.GI1046@wotan.suse.de>
References: <43220.166.84.149.254.1102702048.squirrel@crusoe.degler.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43220.166.84.149.254.1102702048.squirrel@crusoe.degler.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 10, 2004 at 01:07:28PM -0500, Stephen Degler wrote:
> Hello,
> 
> Should i386 NUMA be working on with Opteron systems?  I'm blowing up
> on various Tyan motherboards.  Of course x86_64 kernels run fine.

No. The i386 NUMA support was written for completely different
systems. In theory it could be fixed, but it's probably
not worth it because 32bit NUMA has a lot of problems
and it's much better to use a 64bit kernel on these machines.

However some check should be probably added to avoid the oops.

-Andi
