Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261556AbVCWNDp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261556AbVCWNDp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 08:03:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261586AbVCWNDp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 08:03:45 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:10954 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261556AbVCWNDo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 08:03:44 -0500
Date: Wed, 23 Mar 2005 14:03:32 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: jamal <hadi@cyberus.ca>
cc: linux-kernel@vger.kernel.org
Subject: Re: memory leak in net/sched/ipt.c?
In-Reply-To: <1111581618.1088.72.camel@jzny.localdomain>
Message-ID: <Pine.LNX.4.61.0503231402470.25718@yvahk01.tjqt.qr>
References: <E1DE44X-0001QM-00@gondolin.me.apana.org.au>
 <1111581618.1088.72.camel@jzny.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>Just a small correction to patchlet:
>The second kfree should check for existence of t.

Just look at all the recent patches about "un-useful NULL around kfree", they 
are changing " if(t) kfreee(t) " => kfree(t).
No prob there.


Jan Engelhardt
-- 
