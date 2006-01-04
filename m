Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751194AbWADGpt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751194AbWADGpt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 01:45:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751172AbWADGpt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 01:45:49 -0500
Received: from xproxy.gmail.com ([66.249.82.195]:38939 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751194AbWADGps convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 01:45:48 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=CGFaz/fAIHeXjCJ4gCHhbu2o3+DZ4dVae0I7K99XLq940XmX8+0sORROgrGfj+xEnzufmpE6FDwfqPI2fwBfwpEnKGJPp0oFJSAzaO9WYG7AfOQmVju/+xsJvT0P6YewPl8PPoDFBQIHMcn7Z0UNwNZ0X6+i8TdP5gkft7ncNL0=
Message-ID: <661de9470601032245p6f486c45v92df814beb063766@mail.gmail.com>
Date: Wed, 4 Jan 2006 12:15:47 +0530
From: Balbir Singh <bsingharora@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [patch 4/9] slab: cache_estimate cleanup
Cc: Pekka Enberg <penberg@cs.helsinki.fi>, clameter@sgi.com,
       colpatch@us.ibm.com, manfred@colorfullife.com,
       linux-kernel@vger.kernel.org, akpm@osdl.org
In-Reply-To: <1136339242.12468.17.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1136319948.8629.19.camel@localhost>
	 <1136336416.12468.11.camel@localhost.localdomain>
	 <1136339242.12468.17.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This patch cleans up cache_estimate in mm/slab.c and improves the algorithm
> by taking an initial guess before executing the while loop. The optimization
> was originally made by Balbir Singh with further improvements from Steven
> Rostedt. Manfred Spraul provider further modifications: no loop at all for
> the off-slab case and explain the background.
>
> Signed-off-by: Manfred Spraul <manfred@colorfullife.com>
> Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>

I had prepared this patch about five years ago and completely forgot about it.

Acked-by: Balbir Singh <bsingharora@gmail.com>
