Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262652AbVA0QCD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262652AbVA0QCD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 11:02:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262654AbVA0QCC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 11:02:02 -0500
Received: from relay.2ka.mipt.ru ([194.85.82.65]:33185 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S262652AbVA0QBo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 11:01:44 -0500
Date: Thu, 27 Jan 2005 19:21:09 +0300
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
       Greg Kroah-Hartman <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-rc2-mm1: SuperIO scx200 breakage
Message-ID: <20050127192109.681b32b6@zanzibar.2ka.mipt.ru>
In-Reply-To: <41F90697.5020408@tmr.com>
References: <20050124175449.GK3515@stusta.de>
	<20050124021516.5d1ee686.akpm@osdl.org>
	<20050124214336.2c555b53@zanzibar.2ka.mipt.ru>
	<41F90697.5020408@tmr.com>
Reply-To: johnpol@2ka.mipt.ru
Organization: MIPT
X-Mailer: Sylpheed-Claws 0.9.12b (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Jan 2005 10:19:51 -0500
Bill Davidsen <davidsen@tmr.com> wrote:

> Evgeniy Polyakov wrote:
> > On Mon, 24 Jan 2005 18:54:49 +0100
> > Adrian Bunk <bunk@stusta.de> wrote:
> > 
> > 
> >>It seems noone who reviewed the SuperIO patches noticed that there are 
> >>now two modules "scx200" in the kernel...
> > 
> > 
> > They are almost mutually exlusive(SuperIO contains more advanced), 
> > so I do not see any problem here.
> > Only one of them can be loaded in a time.
> > 
> > So what does exactly bother you?
> >
> That I don't know how to select loading between modules with the same 
> name. What's the trick?

Use full path.
Please see discussion in this thread related to module names.
 
> -- 
>     -bill davidsen (davidsen@tmr.com)
> "The secret to procrastination is to put things off until the
>   last possible moment - but no longer"  -me


	Evgeniy Polyakov

Only failure makes us experts. -- Theo de Raadt
