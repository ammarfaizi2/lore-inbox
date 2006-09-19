Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751985AbWISOGv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751985AbWISOGv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 10:06:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751987AbWISOGu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 10:06:50 -0400
Received: from main.gmane.org ([80.91.229.2]:59016 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751985AbWISOGu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 10:06:50 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Ludovic Drolez <ldrolez@linbox.com>
Subject: Re: [PATCH] sched.c: Be a bit more conservative in SMP
Date: Tue, 19 Sep 2006 14:06:04 +0000 (UTC)
Message-ID: <loom.20060919T155900-330@post.gmane.org>
References: <200609031541.39984.subdino2004@yahoo.fr> <200609031910.57259.vincent.plr@wanadoo.fr> <200609070130.53995.vincent.plr@wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 81.56.128.63 (Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20060628 Debian/1.7.8-1sarge7.1)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vincent Pelletier <vincent.plr <at> wanadoo.fr> writes:
> I'll do some tests soon to see which version gives better performance at a 
> higher level than just process migration cost - if different at all.

I think that your patch should improve the performance because process
migrations are expensive (cache miss) and should be avoided when not 
really necessary.

Cheers,

  Ludovic.


