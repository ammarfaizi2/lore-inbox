Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751259AbWIAGvO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751259AbWIAGvO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 02:51:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751252AbWIAGuu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 02:50:50 -0400
Received: from mx2.go2.pl ([193.17.41.42]:27064 "EHLO poczta.o2.pl")
	by vger.kernel.org with ESMTP id S964871AbWIAGtS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 02:49:18 -0400
Date: Fri, 1 Sep 2006 08:52:39 +0200
From: Jarek Poplawski <jarkao2@o2.pl>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] [ BUG: bad unlock balance detected! ] in 2.6.18-rc5
Message-ID: <20060901065239.GB2065@ff.dom.local>
References: <20060901064319.GA2065@ff.dom.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060901064319.GA2065@ff.dom.local>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 01, 2006 at 08:43:19AM +0200, Jarek Poplawski wrote:
...
> spin_unlock_irqrestore() goes through lockdep
> but spin_lock_irqrestore() doesn't.

but spin_lock_irqsave() doesn't!

Jarek P.
