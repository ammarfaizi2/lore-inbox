Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751491AbWEJPio@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751491AbWEJPio (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 11:38:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751465AbWEJPio
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 11:38:44 -0400
Received: from [63.81.120.158] ([63.81.120.158]:25758 "EHLO
	gateway-1237.mvista.com") by vger.kernel.org with ESMTP
	id S1751490AbWEJPin (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 11:38:43 -0400
Subject: Re: [PATCH -mm] sys_semctl gcc 4.1 warning fix
From: Daniel Walker <dwalker@mvista.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <1147275571.17886.64.camel@localhost.localdomain>
References: <200605100256.k4A2u8bd031779@dwalker1.mvista.com>
	 <1147257266.17886.3.camel@localhost.localdomain>
	 <1147271489.21536.70.camel@c-67-180-134-207.hsd1.ca.comcast.net>
	 <1147273787.17886.46.camel@localhost.localdomain>
	 <1147273598.21536.92.camel@c-67-180-134-207.hsd1.ca.comcast.net>
	 <1147275571.17886.64.camel@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 10 May 2006 08:38:41 -0700
Message-Id: <1147275522.21536.109.camel@c-67-180-134-207.hsd1.ca.comcast.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-05-10 at 16:39 +0100, Alan Cox wrote:
> On Mer, 2006-05-10 at 08:06 -0700, Daniel Walker wrote:
> > > Because while the warning is present people will check it now and again.
> > 
> > But it's pointless to review it, in this case and for this warning .
> 
> Then why did you review it ? 

So I wouldn't have to see that warning again ..

> It reminds people that it does need checking, and ensures now and then
> people do check that there isn't actually a bug there.

I don't see a reason why it needs checking .. People are just going to
spin their wheel reviewing code that's been reviewed .. Maybe someone
like me will write a patch to fix this warning , and we'll see this
process happening all over again ..

Daniel

