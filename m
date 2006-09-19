Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751952AbWISNuS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751952AbWISNuS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 09:50:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751959AbWISNuS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 09:50:18 -0400
Received: from main.gmane.org ([80.91.229.2]:1184 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751952AbWISNuQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 09:50:16 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Ludovic <ldrolez@linbox.com>
Subject: Re: [PATCH] sched.c: Be a bit more conservative in SMP
Date: Tue, 19 Sep 2006 13:39:21 +0000 (UTC)
Message-ID: <loom.20060919T153419-722@post.gmane.org>
References: <200609031541.39984.subdino2004@yahoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 81.56.128.63 (Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20060628 Debian/1.7.8-1sarge7.1)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vincent Pelletier <subdino2004 <at> yahoo.fr> writes:
> I've often seen the following use case happening on the few linux SMP boxes
> I have access to : one process eats one cpu becaus eit has a big
> computation to do, all cpu being idle, and the process keeps on hopping
> from one cpu to another.
> This patch is a quick try to make this behaviour disapear without requiring
> to bind all processes manually with taskset.
> I don't know if there is any practical performance increase (although I
> believe there locally is).

Hi !

Do you know if your patch has been included somewhere ?
We have the same problem on a HPCC here with 4 CPUs per MB, and I don't like
playing with taskset (moreover, performance under Windows *much* is better
without any tuning, shame on us), it would be nice to see less migration when
it's not needed...

Cheers,

  Ludovic.





