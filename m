Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161042AbWIGAzg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161042AbWIGAzg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 20:55:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161043AbWIGAzg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 20:55:36 -0400
Received: from main.gmane.org ([80.91.229.2]:22949 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1161042AbWIGAzf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 20:55:35 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Parag Warudkar <kernel-stuff@comcast.net>
Subject: Re: what is the expected behaviour under extreme high load.
Date: Thu, 7 Sep 2006 00:55:00 +0000 (UTC)
Message-ID: <loom.20060907T025107-236@post.gmane.org>
References: <6b4e42d10609061653p608a2947g1943b3d752855dfe@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 68.60.177.223 (Mozilla/5.0 (Macintosh; U; PPC Mac OS X Mach-O; en-US; rv:1.8.1b2) Gecko/20060821 Firefox/2.0b2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Om Narasimhan <om.turyx <at> gmail.com> writes:

> 
> Hi,
> I am running a stress test on my SunFire 4600 (8x2core, 64G) using the
> mem_test available from
> http://carpanta.dc.fi.udc.es/~quintela/memtest. I am using SuSE
> enterprise 9 SP3.
> 
> I am wondering what is the expected behaviour of a machine under
> extreme VM stress.
> When I stress the system to the limits, it practically becomes
> unresponsive. It runs for almost half an hour and then it crashes
> because of a CPU lockup.

Lockup is certainly not the expected behavior. 

> Pid: 12756, comm: mtest Tainted: G   U   (2.6.5-7.244-smp-dbg )

For one, that's an awfully old kernel that you are running and secondly if you
have support, only SuSE is going to be able to help you with this problem since
it's not a stock kernel.org kernel but a SuSE one. 

Alternatively, you could run the latest stable kernel (http://kernel.org) and
try to reproduce the problem.

Hope that helps.

Parag

