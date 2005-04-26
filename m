Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261395AbVDZIjh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261395AbVDZIjh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 04:39:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261397AbVDZIjh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 04:39:37 -0400
Received: from mx1.redhat.com ([66.187.233.31]:8642 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261395AbVDZIje (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 04:39:34 -0400
Date: Tue, 26 Apr 2005 16:43:18 +0800
From: David Teigland <teigland@redhat.com>
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH 1a/7] dlm: core locking
Message-ID: <20050426084318.GG12096@redhat.com>
References: <20050425165705.GA11938@redhat.com> <Pine.LNX.4.62.0504252242510.2941@dragon.hyggekrogen.localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0504252242510.2941@dragon.hyggekrogen.localhost>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25, 2005 at 11:17:57PM +0200, Jesper Juhl wrote:

>                                    |----- Why the parenthesis?
>                                  ^^^^^--- more parens.
>                                  ^^^^^--- yet more.
>                                   what's your facination with parenthesis?
>                                   ^--- here we go again.
>                                   ^--- and again.
> a few cases of pointless parenthesis around define values...
> Here, again, we have a lot of pointless parenthesis around the values.
> I'm not going to bother pointing out the remaining ones.

Hm, you might have removed some remaining doubt about my paren usage.
Anyway, they're all gone now.


> > +	int 	 sb_status;
> > +	uint32_t sb_lkid;
> > +	char 	 sb_flags;
> > +	char *	 sb_lvbptr;

> why not	char	*sb_lvbptr; ???

I personally think the right column looks nicer when it's lined up, but a
quick survey shows I'm in the minority, so I'd better get with the
program...


> > +static int dlm_astd(void *data)
> Always returning 0 - why not a void function then?

> > +int dlm_scand(void *data)
> void func?

I think kthread_run() demands this.

Dave

