Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262835AbULREDw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262835AbULREDw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 23:03:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262836AbULREDv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 23:03:51 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:56276 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262835AbULREDr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 23:03:47 -0500
Date: Fri, 17 Dec 2004 23:03:12 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Jason Baron <jbaron@redhat.com>
Cc: Horms <horms@verge.net.au>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Sergey Vlasov <vsu@altlinux.ru>
Subject: Re: tty/ldisc fix in 2.4
Message-ID: <20041218010312.GA25855@logos.cnet>
References: <Pine.LNX.4.44.0412161002520.28739-100000@dhcp83-105.boston.redhat.com> <Pine.LNX.4.44.0412171451270.8435-100000@dhcp83-105.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0412171451270.8435-100000@dhcp83-105.boston.redhat.com>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 17, 2004 at 02:52:43PM -0500, Jason Baron wrote:
> 
> On Thu, 16 Dec 2004, Jason Baron wrote:
> 
> > the latest one was the last one posted to this list plus Sergey's fixes.  
> > However, i think it was still missing some driver cleanups. I'll post an
> > updated patch here.
> > 
> 
> updated patch at: http://people.redhat.com/~jbaron/tty/2.4-tty-V8.patch.  
> This patch adds 'tty_wakeup' and 'tty_ldisc_flush' calls to additional
> drivers. It also includes the two patches that Sergey previous posted. 

Its merged. 

[PATCH] Backport v2.6 tty/ldisc locking fixes

I fail to credit you properly on the changelog, sorry: 
I can't change a comment after it has been merged and I did 
a direct "bk import -tpatch". 
