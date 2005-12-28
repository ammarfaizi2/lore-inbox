Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932447AbVL1C0v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932447AbVL1C0v (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Dec 2005 21:26:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932448AbVL1C0v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Dec 2005 21:26:51 -0500
Received: from MAIL.13thfloor.at ([212.16.62.50]:14242 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S932447AbVL1C0v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Dec 2005 21:26:51 -0500
Date: Wed, 28 Dec 2005 03:26:50 +0100
From: Herbert Poetzl <herbert@13thfloor.at>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: overview on www.kernel.org subtly broken ...
Message-ID: <20051228022650.GA16013@MAIL.13thfloor.at>
Mail-Followup-To: "H. Peter Anvin" <hpa@zytor.com>,
	Linux Kernel ML <linux-kernel@vger.kernel.org>
References: <20051227172319.GA7429@MAIL.13thfloor.at> <43B1BCB4.4050700@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43B1BCB4.4050700@zytor.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 27, 2005 at 02:14:12PM -0800, H. Peter Anvin wrote:
> Herbert Poetzl wrote:
> >Hi!
> >
> >the script which does the overview on the
> >main page (http://www.kernel.org) is subtly
> >broken in that way that it kind-of falls
> >back to a previous snapshot when the latest
> >prepatch is updated, it will then take a
> >'new' snapshot release to come back to normal
> >(as it is right now)
> >
> >best,
> >Herbert
> 
> It's not broken.

hmm ... had to dig that out, as the #kernelnebies 
irc log search is 'not' broken either ...

-------------------
The latest prepatch for the stable Linux kernel tree is:  2.6.15-rc7     2005-12-25
The latest snapshot for the stable Linux kernel tree is:  2.6.14-git14   2005-11-11

that was on the 25th of December, around 19:30

note that at this time the latest snapshot actually
was patch-2.6.15-rc6-git4 and not 2.6.14-git14 as 
the script wanted to make us believe (which is the
last 2.6.14-git)

so, as we now 'know' that this is intentional, please
just explain (to me and other confused folks) what
the intentions behind that actually are.

TIA,
Herbert

> 	-hpa
