Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750712AbWIHWsH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750712AbWIHWsH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 18:48:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751120AbWIHWsH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 18:48:07 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:1799 "EHLO spitz.ucw.cz")
	by vger.kernel.org with ESMTP id S1750712AbWIHWsE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 18:48:04 -0400
Date: Fri, 8 Sep 2006 22:47:52 +0000
From: Pavel Machek <pavel@suse.cz>
To: Metathronius Galabant <m.galabant@googlemail.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: top displaying 50% si time and 50% idle on idle machine
Message-ID: <20060908224752.GK8793@ucw.cz>
References: <1b270aae0609071108h22bc10b0v5d2227abfc66c53c@mail.gmail.com> <20060907175323.57a5c6b0.akpm@osdl.org> <1b270aae0609081403u11b76ae9v72ad933475a2319f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1b270aae0609081403u11b76ae9v72ad933475a2319f@mail.gmail.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >>Cpu(s):  0.0% us,  0.0% sy,  0.0% ni, 50.0% id,  0.0% 
> >>wa,  0.0% hi, 50.0%si
> 
> >Do `ps aux', look for a process stuck in D state.
> 
> The issue that startled me: there is _NO_ process in a D 
> state!
> BTW what means si? (interrupt service time? google 
> didn't find anything)

'soft interrupt' probably. try disconnecting network.

						Pavel

-- 
Thanks for all the (sleeping) penguins.
