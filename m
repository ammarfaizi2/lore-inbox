Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261863AbUCDM2r (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 07:28:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261864AbUCDM2r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 07:28:47 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:29838 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S261863AbUCDM2p
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 07:28:45 -0500
Subject: Re: About Replaceable OOM Killer
From: "Yury V. Umanets" <umka@namesys.com>
To: "Tvrtko A." =?iso-8859-2?Q?Ur=B9ulin?= <tvrtko@croadria.com>
Cc: linux-kernel@vger.kernel.org, "Guo, Min" <min.guo@intel.com>,
       cgl_discussion@lists.osdl.org
In-Reply-To: <200403011141.26724.tvrtko@croadria.com>
References: <3ACA40606221794F80A5670F0AF15F84035F1DD5@PDSMSX403.ccr.corp.intel.com>
	 <200403011141.26724.tvrtko@croadria.com>
Content-Type: text/plain; charset=iso-8859-2
Organization: NAMESYS
Message-Id: <1078403388.3025.33.camel@firefly>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Thu, 04 Mar 2004 14:29:48 +0200
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-03-01 at 12:41, Tvrtko A. Ur¹ulin wrote:
> On Monday 01 March 2004 06:53, Guo, Min wrote:
> 
> > 	How about your idea on the proposal? Any comments are welcome!
> 
> You can also try:
> 
> http://www.linux.ursulin.net/moom-2.4.22-1.patch
> 
> Though it hasn't been updated for a while because nobody cares...
IMHO problem with OOM killer is that it always will do wrong choice. So,
it should be either plugin based or allow to configure it and this
means, that it will become more complex and buggy. Does not it mean,
that OOM killer should be moved to user space?

How about to export OOM event to user space? It might be done in manner
like hotplug script is used.

> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
umka

