Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261936AbTJXBwT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Oct 2003 21:52:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261938AbTJXBwT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Oct 2003 21:52:19 -0400
Received: from hockin.org ([66.35.79.110]:17670 "EHLO www.hockin.org")
	by vger.kernel.org with ESMTP id S261936AbTJXBwS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Oct 2003 21:52:18 -0400
Date: Thu, 23 Oct 2003 18:42:09 -0700
From: Tim Hockin <thockin@hockin.org>
To: Ian Kent <raven@themaw.net>
Cc: Mike Waychison <Michael.Waychison@Sun.COM>,
       Ingo Oeser <ioe-lkml@rameria.de>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>, torvalds@osdl.org
Subject: Re: [NFS] RE: [autofs] multiple servers per automount
Message-ID: <20031024014209.GA23734@hockin.org>
References: <3F980949.1040201@sun.com> <Pine.LNX.4.33.0310240839090.14084-100000@wombat.indigo.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0310240839090.14084-100000@wombat.indigo.net.au>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Recap: Mike Waychison posted a simple patch to make Max_anon bit array
(NFS mounts etc.) use exactly one page.

On Fri, Oct 24, 2003 at 08:47:57AM +0800, Ian Kent wrote:
> I there any chance this would be accepted into 2.6.0?
> 
> I think it's quite important, hopefully others do as well.


Wouldn't it be saner to have a sysctl to adjust that?  From 1 page to
2^20/(PAGE_SIZE * CHAR_BIT) pages?  Perhaps just in page-sized increments?

This would be a simple patch... But maybe it's not 'stabilization' for
2.6.0.

Maybe the simple version in 2.6.0 and the right version in 2.6.1?

Linus?

