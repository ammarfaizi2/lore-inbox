Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750938AbVKUAjP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750938AbVKUAjP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Nov 2005 19:39:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932140AbVKUAjP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Nov 2005 19:39:15 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:61057 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1750938AbVKUAjO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Nov 2005 19:39:14 -0500
Date: Sun, 20 Nov 2005 23:27:32 +0000
From: Pavel Machek <pavel@suse.cz>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Andrew Morton <akpm@osdl.org>, "David S. Miller" <davem@davemloft.net>,
       davej@redhat.com, bunk@stusta.de, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] mark virt_to_bus/bus_to_virt as __deprecated on i386
Message-ID: <20051120232731.GG2556@spitz.ucw.cz>
References: <20051118024433.GN11494@stusta.de> <20051117185529.31d33192.akpm@osdl.org> <20051118031751.GA2773@redhat.com> <20051117.194239.37311109.davem@davemloft.net> <20051117200354.6acb3599.akpm@osdl.org> <20051119003435.GA29775@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051119003435.GA29775@mars.ravnborg.org>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 19-11-05 01:34:35, Sam Ravnborg wrote:
> On Thu, Nov 17, 2005 at 08:03:54PM -0800, Andrew Morton wrote:
> > "David S. Miller" <davem@davemloft.net> wrote:
> > >
> > > The deprecated warnings are so easy to filter out, so I don't think
> > >  noise is a good argument.  I see them all the time too.
> > 
> > That works for you and me.  But how to train all those people who write
> > warny patches?
> 
> Would it work to use -Werror only on some parts of the kernel.
> Thinking of teaching kbuild to recursively apply a flags to gcc.
> 
> Then we could say that kernel/ should be warning free (to a start).

Well, please don't do that. -Werror makes development very painful.

							Pavel
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

