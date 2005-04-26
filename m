Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261691AbVDZR4O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261691AbVDZR4O (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 13:56:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261750AbVDZRyS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 13:54:18 -0400
Received: from mail.dif.dk ([193.138.115.101]:21183 "EHLO saerimmer.dif.dk")
	by vger.kernel.org with ESMTP id S261505AbVDZRxz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 13:53:55 -0400
Date: Tue, 26 Apr 2005 19:57:11 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Robert Love <rml@novell.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       kpreempt-tech@lists.sourceforge.net
Subject: Re: preempt-count oddities - still looking for comments :)
In-Reply-To: <1114537590.6851.3.camel@betsy>
Message-ID: <Pine.LNX.4.62.0504261951370.2071@dragon.hyggekrogen.localhost>
References: <Pine.LNX.4.62.0504232254050.2474@dragon.hyggekrogen.localhost>
  <Pine.LNX.4.62.0504261929230.2071@dragon.hyggekrogen.localhost> 
 <1114536937.6851.1.camel@betsy>  <Pine.LNX.4.62.0504261944020.2071@dragon.hyggekrogen.localhost>
 <1114537590.6851.3.camel@betsy>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Apr 2005, Robert Love wrote:

> On Tue, 2005-04-26 at 19:46 +0200, Jesper Juhl wrote:
> 
> > I'll update the patch(es) then and use __s32 in the structure and s32 
> > elsewhere.
> 
> You can actually use s32 everywhere, since the structure is never
> exported to user-space...

Right, I'll do that then.

> although some architectures already have the
> __ugly versions in there.
> 

Not for long :)


-- 
Jesper

