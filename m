Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262134AbULQTwC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262134AbULQTwC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 14:52:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262146AbULQTwC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 14:52:02 -0500
Received: from mx1.redhat.com ([66.187.233.31]:49586 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262134AbULQTv7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 14:51:59 -0500
Date: Fri, 17 Dec 2004 14:52:43 -0500 (EST)
From: Jason Baron <jbaron@redhat.com>
X-X-Sender: jbaron@dhcp83-105.boston.redhat.com
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
cc: Horms <horms@verge.net.au>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Sergey Vlasov <vsu@altlinux.ru>
Subject: Re: tty/ldisc fix in 2.4
In-Reply-To: <Pine.LNX.4.44.0412161002520.28739-100000@dhcp83-105.boston.redhat.com>
Message-ID: <Pine.LNX.4.44.0412171451270.8435-100000@dhcp83-105.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 16 Dec 2004, Jason Baron wrote:

> the latest one was the last one posted to this list plus Sergey's fixes.  
> However, i think it was still missing some driver cleanups. I'll post an
> updated patch here.
> 

updated patch at: http://people.redhat.com/~jbaron/tty/2.4-tty-V8.patch.  
This patch adds 'tty_wakeup' and 'tty_ldisc_flush' calls to additional
drivers. It also includes the two patches that Sergey previous posted. 

thanks,

-Jason
  


