Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932476AbWGaG4E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932476AbWGaG4E (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 02:56:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932484AbWGaG4D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 02:56:03 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:3482 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932476AbWGaG4B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 02:56:01 -0400
Date: Mon, 31 Jul 2006 16:55:22 +1000
From: Nathan Scott <nathans@sgi.com>
To: kernel <linux@idccenter.cn>
Cc: jdi@l4x.org, linux-kernel@vger.kernel.org
Subject: Re: XFS Bug null pointer dereference in xfs_free_ag_extent
Message-ID: <20060731165522.K2280998@wobbly.melbourne.sgi.com>
References: <44BF29CD.1000809@l4x.org> <44CB0BF7.6030204@idccenter.cn> <44CB1303.7010303@l4x.org> <20060731094424.E2280998@wobbly.melbourne.sgi.com> <44CDA156.6000105@idccenter.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <44CDA156.6000105@idccenter.cn>; from linux@idccenter.cn on Mon, Jul 31, 2006 at 02:21:10PM +0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 31, 2006 at 02:21:10PM +0800, kernel wrote:
> Test again......very strange.
> I can easily reproduce it on the XFS with SAN(FLX380) connected with a 
> qlogic 2400 FC card.

Eggshellent... can you reproduce it with each of those changes
(below) backed out of your tree please?  Else, git bisect is our
next best bet.  Thanks!

> > Is this easily reproducible for you?  I've not seen it before, and
> > the only possibly related recent changes I can think of are these:
> >
> > http://git.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=e63a3690013a475746ad2cea998ebb534d825704
> >
> > http://git.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=d210a28cd851082cec9b282443f8cc0e6fc09830
> >
> > Could you try reverting each of those to see if either is the cause?

cheers.

-- 
Nathan
