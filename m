Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S261236AbUKEW0y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261236AbUKEW0y (ORCPT <rfc822;akpm@zip.com.au>);
	Fri, 5 Nov 2004 17:26:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261240AbUKEWYr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 17:24:47 -0500
Received: from sd291.sivit.org ([194.146.225.122]:48061 "EHLO sd291.sivit.org")
	by vger.kernel.org with ESMTP id S261236AbUKEWYc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 17:24:32 -0500
Date: Fri, 5 Nov 2004 23:25:02 +0100
From: Stelian Pop <stelian@popies.net>
To: Roland Mas <roland.mas@free.fr>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: meye bug?  No.
Message-ID: <20041105222502.GD3996@deep-space-9.dsnet>
Reply-To: Stelian Pop <stelian@popies.net>
Mail-Followup-To: Stelian Pop <stelian@popies.net>,
	Roland Mas <roland.mas@free.fr>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20041104111231.GF3472@crusoe.alcove-fr> <87zn1xjoqo.fsf@mirexpress.internal.placard.fr.eu.org> <20041104215805.GB3996@deep-space-9.dsnet> <87actwo87q.fsf_-_@cachemir.echo-net.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87actwo87q.fsf_-_@cachemir.echo-net.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 05, 2004 at 12:18:01PM +0100, Roland Mas wrote:

> > :)
> 
> Okay, so I made a fool of myself, hope you had fun, sorry for the
> inconvenience otherwise :-)

No problem :)
> 
>   Seriously though, and as much as I know I should have read the docs,
> is this detectable from meye?  If it is, I suggest it would be a nice
> thing to have a different or more explicit error message.  Just "meye:
> need to reset HIC, is sonypi correctly configured?" would be cool.

As a matter of fact it is quite detectable yes. I'll put in a check
which will even fail to load the meye module (with an explicit
error message) if sonypi isn't loaded with camera=1.

The only disadvantage of that is that it won't catch anymore the
users who don't RTFM :)

Stelian.
-- 
Stelian Pop <stelian@popies.net>
