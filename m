Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263356AbVGOOc5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263356AbVGOOc5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 10:32:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263364AbVGOOc5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 10:32:57 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:27340 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S263356AbVGOOcs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 10:32:48 -0400
Date: Fri, 15 Jul 2005 15:32:38 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Christoph Hellwig <hch@infradead.org>, Chris Wright <chrisw@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Add security_task_post_setgid
Message-ID: <20050715143238.GA5759@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Jan Engelhardt <jengelh@linux01.gwdg.de>,
	Chris Wright <chrisw@osdl.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.61.0507142339570.3256@yvahk01.tjqt.qr> <20050714223807.GA25671@infradead.org> <Pine.LNX.4.61.0507150951150.20435@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0507150951150.20435@yvahk01.tjqt.qr>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 15, 2005 at 09:54:40AM +0200, Jan Engelhardt wrote:
> 
> >> the following patch adds a post_setgid() security hook, and necessary dummy 
> >> funcs.
> >
> >... and why exactly would we want these?
> 
> I am working on a sec module which, among other things, raises certain 
> capabilities when the UID/GID has been successfully changed.

So keep the patch part of your module, it has no business in mainline
so far.

