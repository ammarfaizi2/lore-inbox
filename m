Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261866AbVGOHzH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261866AbVGOHzH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 03:55:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263234AbVGOHzH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 03:55:07 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:34991 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261866AbVGOHzF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 03:55:05 -0400
Date: Fri, 15 Jul 2005 09:54:40 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Christoph Hellwig <hch@infradead.org>, Chris Wright <chrisw@osdl.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Add security_task_post_setgid
In-Reply-To: <20050714223807.GA25671@infradead.org>
Message-ID: <Pine.LNX.4.61.0507150951150.20435@yvahk01.tjqt.qr>
References: <Pine.LNX.4.61.0507142339570.3256@yvahk01.tjqt.qr>
 <20050714223807.GA25671@infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> the following patch adds a post_setgid() security hook, and necessary dummy 
>> funcs.
>
>... and why exactly would we want these?

I am working on a sec module which, among other things, raises certain 
capabilities when the UID/GID has been successfully changed.


Jan Engelhardt
-- 
