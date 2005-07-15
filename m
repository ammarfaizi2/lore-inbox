Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263326AbVGOQal@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263326AbVGOQal (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 12:30:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263323AbVGOQah
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 12:30:37 -0400
Received: from smtp.osdl.org ([65.172.181.4]:48082 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S263322AbVGOQae (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 12:30:34 -0400
Date: Fri, 15 Jul 2005 09:30:12 -0700
From: Chris Wright <chrisw@osdl.org>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Christoph Hellwig <hch@infradead.org>, Chris Wright <chrisw@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Add security_task_post_setgid
Message-ID: <20050715163012.GN9153@shell0.pdx.osdl.net>
References: <Pine.LNX.4.61.0507142339570.3256@yvahk01.tjqt.qr> <20050714223807.GA25671@infradead.org> <Pine.LNX.4.61.0507150951150.20435@yvahk01.tjqt.qr> <20050715143238.GA5759@infradead.org> <Pine.LNX.4.61.0507151648590.29120@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0507151648590.29120@yvahk01.tjqt.qr>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Jan Engelhardt (jengelh@linux01.gwdg.de) wrote:
> And when is this becoming business? What made post_setUid go into the kernel?

That went as part of supporting capabilities as they were, to do fixups
on set{r,e,s}uid.
