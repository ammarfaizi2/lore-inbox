Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265882AbTGADLM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jun 2003 23:11:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265902AbTGADLL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jun 2003 23:11:11 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:55264
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S265882AbTGADLK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jun 2003 23:11:10 -0400
Date: Tue, 1 Jul 2003 05:25:08 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@digeo.com>
Cc: mel@csn.ul.ie, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: What to expect with the 2.6 VM
Message-ID: <20030701032508.GN3040@dualathlon.random>
References: <Pine.LNX.4.53.0307010238210.22576@skynet> <20030701022516.GL3040@dualathlon.random> <20030630200237.473d5f82.akpm@digeo.com> <20030701032248.GM3040@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030701032248.GM3040@dualathlon.random>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 01, 2003 at 05:22:48AM +0200, Andrea Arcangeli wrote:
> On Mon, Jun 30, 2003 at 08:02:37PM -0700, Andrew Morton wrote:
> > callers are fixed up to not require NOFAIL then we don't need it any more.
> 
> Agreed indeed.

I also found one argument in favour of NOFAIL: now it'll be easier to
find all the deadlocking places ;)

Andrea
