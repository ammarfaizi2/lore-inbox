Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261337AbVAXSz5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261337AbVAXSz5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 13:55:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261568AbVAXSz4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 13:55:56 -0500
Received: from anchor-post-33.mail.demon.net ([194.217.242.91]:21520 "EHLO
	anchor-post-33.mail.demon.net") by vger.kernel.org with ESMTP
	id S261337AbVAXSzv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 13:55:51 -0500
From: Stephen Kitchener <stephen@g6dzj.demon.co.uk>
Organization: None
To: Anssi Hannula <anssi.hannula@mbnet.fi>
Subject: Re: System beeper - no sound from mobo's own speaker
Date: Mon, 24 Jan 2005 18:55:50 +0000
User-Agent: KMail/1.6.1
Cc: linux-kernel@vger.kernel.org
References: <200501231937.53099.stephen@g6dzj.demon.co.uk> <200501232007.21027.stephen@g6dzj.demon.co.uk> <ct16l6$jra$1@sea.gmane.org>
In-Reply-To: <ct16l6$jra$1@sea.gmane.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200501241855.50361.stephen@g6dzj.demon.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 23 Jan 2005 21:58, Anssi Hannula wrote:
> Stephen Kitchener wrote:
> > On Sunday 23 Jan 2005 19:50, Sergey Vlasov wrote:
> >>Does "modprobe pcspkr" help?  In 2.6.x kernels the PC speaker support
> >>can be built as a loadable module; probably the startup scripts do not
> >>load it automatically.
> >
> > You know - I've just found that and yes it does help on one system, so
> > I'm 50% better off - just need to find out where to put the command so
> > that it loads it on startup...modules.conf would be it I guess.
>
> Put it on /etc/modprobe.preload

Thanks

-- 
                 O  o
            _\_   o
         \\/  o\ .
         //\___=
            ''
Mon, 24 Jan 2005 18:55:40 +0000
 18:55:40 up  8:55,  0 users,  load average: 1.12, 1.23, 1.19
Life in the state of nature is solitary, poor, nasty, brutish, and short.
- Thomas Hobbes, Leviathan
