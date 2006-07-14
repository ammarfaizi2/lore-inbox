Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161240AbWGNEZh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161240AbWGNEZh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 00:25:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161258AbWGNEZh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 00:25:37 -0400
Received: from 1wt.eu ([62.212.114.60]:20234 "EHLO 1wt.eu")
	by vger.kernel.org with ESMTP id S1161240AbWGNEZh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 00:25:37 -0400
Date: Fri, 14 Jul 2006 06:25:25 +0200
From: Willy Tarreau <w@1wt.eu>
To: Dave Jones <davej@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: memory corruptor in .18rc1-git
Message-ID: <20060714042525.GH2037@1wt.eu>
References: <20060713221330.GB3371@redhat.com> <20060713152425.86412ea3.akpm@osdl.org> <20060713223029.GD3371@redhat.com> <20060714041254.GG2037@1wt.eu> <20060714042039.GB22802@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060714042039.GB22802@redhat.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 14, 2006 at 12:20:40AM -0400, Dave Jones wrote:
> On Fri, Jul 14, 2006 at 06:12:54AM +0200, Willy Tarreau wrote:
>  
>  > > I can give it a shot, but as it takes a while for this to manifest, I may
>  > > not be able to say for certain whether it fixes it or not.
>  > 
>  > Then you might consider slightly changing the debug messages, because they
>  > are identical in list_add and list_del. Having a way to differenciate
>  > between the two functions might give one more indication.
> 
> BUG() gives a line number.

oops! sorry, I did not notice it just after the printk(). Next time I will
not post before coffee :-)

> 		Dave

Willy

