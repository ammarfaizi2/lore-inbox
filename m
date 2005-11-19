Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751123AbVKSAdc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751123AbVKSAdc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 19:33:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751129AbVKSAdc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 19:33:32 -0500
Received: from pfepb.post.tele.dk ([195.41.46.236]:28685 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S1751123AbVKSAdc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 19:33:32 -0500
Date: Sat, 19 Nov 2005 01:34:35 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Andrew Morton <akpm@osdl.org>
Cc: "David S. Miller" <davem@davemloft.net>, davej@redhat.com, bunk@stusta.de,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] mark virt_to_bus/bus_to_virt as __deprecated on i386
Message-ID: <20051119003435.GA29775@mars.ravnborg.org>
References: <20051118024433.GN11494@stusta.de> <20051117185529.31d33192.akpm@osdl.org> <20051118031751.GA2773@redhat.com> <20051117.194239.37311109.davem@davemloft.net> <20051117200354.6acb3599.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051117200354.6acb3599.akpm@osdl.org>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2005 at 08:03:54PM -0800, Andrew Morton wrote:
> "David S. Miller" <davem@davemloft.net> wrote:
> >
> > The deprecated warnings are so easy to filter out, so I don't think
> >  noise is a good argument.  I see them all the time too.
> 
> That works for you and me.  But how to train all those people who write
> warny patches?

Would it work to use -Werror only on some parts of the kernel.
Thinking of teaching kbuild to recursively apply a flags to gcc.

Then we could say that kernel/ should be warning free (to a start).

	Sam
