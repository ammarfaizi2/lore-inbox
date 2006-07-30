Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964795AbWG3XpT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964795AbWG3XpT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 19:45:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964796AbWG3XpS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 19:45:18 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:21377 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S964795AbWG3XpR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 19:45:17 -0400
Date: Mon, 31 Jul 2006 09:44:24 +1000
From: Nathan Scott <nathans@sgi.com>
To: Jan Dittmer <jdi@l4x.org>, kernel <linux@idccenter.cn>
Cc: linux-kernel@vger.kernel.org, xfs@oss.sgi.com
Subject: Re: XFS Bug null pointer dereference in xfs_free_ag_extent
Message-ID: <20060731094424.E2280998@wobbly.melbourne.sgi.com>
References: <44BF29CD.1000809@l4x.org> <44CB0BF7.6030204@idccenter.cn> <44CB1303.7010303@l4x.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <44CB1303.7010303@l4x.org>; from jdi@l4x.org on Sat, Jul 29, 2006 at 09:49:23AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

On Sat, Jul 29, 2006 at 09:49:23AM +0200, Jan Dittmer wrote:
> kernel schrieb:
> > I have the same problem, but it seems not have a patch right now.
> 
> No, I got zero feedback, but let's cc the correct
> mailing list. I also filed bug 6877 at kernel.org
> 

Is this easily reproducible for you?  I've not seen it before, and
the only possibly related recent changes I can think of are these:

http://git.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=e63a3690013a475746ad2cea998ebb534d825704

http://git.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=d210a28cd851082cec9b282443f8cc0e6fc09830

Could you try reverting each of those to see if either is the cause?

thanks.

-- 
Nathan
