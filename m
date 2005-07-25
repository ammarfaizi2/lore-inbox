Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261390AbVGYRJf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261390AbVGYRJf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 13:09:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261392AbVGYRJf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 13:09:35 -0400
Received: from ms004msg.fastwebnet.it ([213.140.2.58]:12781 "EHLO
	ms004msg.fastwebnet.it") by vger.kernel.org with ESMTP
	id S261390AbVGYRIq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 13:08:46 -0400
Date: Mon, 25 Jul 2005 19:07:31 +0200
From: Paolo Ornati <ornati@fastwebnet.it>
To: Bill Davidsen <davidsen@tmr.com>
Cc: lgb@lgb.hu, linux-kernel@vger.kernel.org
Subject: Re: Kernel cached memory
Message-ID: <20050725190731.0d634842@localhost>
In-Reply-To: <42E517B6.1010704@tmr.com>
References: <003401c58ea2$4dfd76f0$5601010a@ashley>
	<20050722132523.GJ20995@vega.lgb.hu>
	<42E517B6.1010704@tmr.com>
X-Mailer: Sylpheed-Claws 1.0.4a (GTK+ 1.2.10; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Jul 2005 12:47:50 -0400
Bill Davidsen <davidsen@tmr.com> wrote:

> And IMHO Linux is *way* too willing to evicy clean pages of my 
> programs to use as disk buffer, so that when system memory is full I
> pay  the overhead of TWO disk i/o's, one to finally write the data to
> the  disk and one to read my program back in. If free software is
> about  choice, I wish there was more in the area of how memory is
> used.

isn't this tuned enough by "/proc/sys/vm/swappiness" ?

-- 
	Paolo Ornati
	Linux 2.6.13-rc3 on x86_64
