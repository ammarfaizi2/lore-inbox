Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261260AbVFHOdY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261260AbVFHOdY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 10:33:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261251AbVFHOdY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 10:33:24 -0400
Received: from wombat.indigo.net.au ([202.0.185.19]:23563 "EHLO
	wombat.indigo.net.au") by vger.kernel.org with ESMTP
	id S261260AbVFHOdR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 10:33:17 -0400
Date: Wed, 8 Jun 2005 22:28:40 +0800 (WST)
From: raven@themaw.net
To: Denis Vlasenko <vda@ilport.com.ua>
cc: Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org,
       reiserfs-dev@namesys.com
Subject: Re: RFC: i386: kill !4KSTACKS
In-Reply-To: <200506081342.53864.vda@ilport.com.ua>
Message-ID: <Pine.LNX.4.63.0506082227340.1617@donald.themaw.net>
References: <20050607212706.GB7962@stusta.de> <Pine.LNX.4.58.0506080948540.29656@wombat.indigo.net.au>
 <200506081342.53864.vda@ilport.com.ua>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam, SpamAssassin (score=-100.6, required 8,
	EMAIL_ATTRIBUTION, IN_REP_TO, NO_REAL_NAME, QUOTED_EMAIL_TEXT,
	RCVD_IN_ORBS, RCVD_IN_OSIRUSOFT_COM, REFERENCES, REPLY_WITH_QUOTES,
	USER_AGENT_PINE, USER_IN_WHITELIST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Jun 2005, Denis Vlasenko wrote:

> On Wednesday 08 June 2005 04:52, Ian Kent wrote:
> > On Tue, 7 Jun 2005, Adrian Bunk wrote:
> > 
> > > 4Kb kernel stacks are the future on i386, and it seems the problems it 
> > > initially caused are now sorted out.
> > > 
> > > I'd like to:
> > > - get a patch into the next -mm that unconditionally enables 4KSTACKS
> > > - if there won't be new reports of breakages, send a patch to
> > >   completely remove !4KSTACKS for 2.6.13 or 2.6.14
> > > 
> > > The only drawback is that REISER4_FS does still depend on !4KSTACKS.
> > > I told Hans back in March that this has to be changed.
> > 
> > What about ndiswrapper?
> > Why is it so important to make this happen unconditionally?
> 
> Number of folks using ndiswrapper for acx100/acx111
> while acx team needs help on native driver debugging
> worries me.

And there's no support for any wireless usb devices that I can see as yet.

Ian

