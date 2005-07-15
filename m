Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263299AbVGON6t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263299AbVGON6t (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 09:58:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263302AbVGON6t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 09:58:49 -0400
Received: from main.gmane.org ([80.91.229.2]:28649 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S263299AbVGON5x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 09:57:53 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Joe Seigh <jseigh_02@xemaps.com>
Subject: Re: rcu-refcount stacker performance
Date: Fri, 15 Jul 2005 09:59:15 -0400
Message-ID: <db8fa3$t3o$1@sea.gmane.org>
References: <20050714142107.GA20984@serge.austin.ibm.com> <20050714152321.GB1299@us.ibm.com> <20050714134450.GB7296@sergelap.austin.ibm.com> <20050714165936.GE1299@us.ibm.com> <20050714171357.GA23309@serge.austin.ibm.com> <db6vsm$fpm$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: stenquists.hsd1.ma.comcast.net
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
In-Reply-To: <db6vsm$fpm$1@sea.gmane.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joe Seigh wrote:
> A bit sketchy.  You can see a working example of this using
> C++ refcounted pointers (which can't be used in the kernel
> naturally, you'll have to implement your own) at
> http://atomic-ptr-plus.sourceforge.net/

The APPC stuff is in the atomic-ptr-plus package if anyone is
wondering where it is.  It was one of what I guess you'd
call strawman packages.  The RCU+SMR (fastsmr) package is
currently the one I'll probably carry forward.

> 
> -- 
> Joe Seigh
> 

