Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261450AbVDQTxV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261450AbVDQTxV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Apr 2005 15:53:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261449AbVDQTxV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Apr 2005 15:53:21 -0400
Received: from mail1.expro.pl ([193.25.166.5]:58265 "HELO mail1.expro.pl")
	by vger.kernel.org with SMTP id S261450AbVDQTxS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Apr 2005 15:53:18 -0400
Date: Sun, 17 Apr 2005 21:53:15 +0200
From: Marcin Owsiany <porridge@expro.pl>
To: linux-kernel@vger.kernel.org
Subject: Re: "swap_free: Unused swap offset entry 00000100" but no crash?
Message-ID: <20050417195315.GA11563@mail1.expro.pl>
References: <20040727002154.GA21628@melina.ds14.agh.edu.pl> <3808.1090931402@ocs3.ocs.com.au> <20040727125304.GA1411@lnx-holt.americas.sgi.com> <20040727185859.GB19107@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040727185859.GB19107@logos.cnet>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 27, 2004 at 03:58:59PM -0300, Marcelo Tosatti wrote:
> On Tue, Jul 27, 2004 at 07:53:04AM -0500, Robin Holt wrote:
> > Marcin, you have a process with a Page Table Entry which indicates it is
> > pointing to a page which has been swapped out to block 0 of swap device
> > 256.  This is probably caused by a problem in the kernel.  You can certainly
> > run memtest et al.  If you don't find anything, I would assume the problem
> > is in the kernel.
> 
> Marcin, please run the memtest86 and report back.

Finally I was able to take the machine down and test its memory. Indeed
one of the modules was faulty (the very first run of memtest revealed
it).

thanks,

Marcin
-- 
Marcin Owsiany
porridge@expro.pl
