Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964973AbWEJPGk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964973AbWEJPGk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 11:06:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964975AbWEJPGk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 11:06:40 -0400
Received: from [63.81.120.158] ([63.81.120.158]:59018 "EHLO
	gateway-1237.mvista.com") by vger.kernel.org with ESMTP
	id S964973AbWEJPGj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 11:06:39 -0400
Subject: Re: [PATCH -mm] sys_semctl gcc 4.1 warning fix
From: Daniel Walker <dwalker@mvista.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <1147273787.17886.46.camel@localhost.localdomain>
References: <200605100256.k4A2u8bd031779@dwalker1.mvista.com>
	 <1147257266.17886.3.camel@localhost.localdomain>
	 <1147271489.21536.70.camel@c-67-180-134-207.hsd1.ca.comcast.net>
	 <1147273787.17886.46.camel@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 10 May 2006 08:06:37 -0700
Message-Id: <1147273598.21536.92.camel@c-67-180-134-207.hsd1.ca.comcast.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-05-10 at 16:09 +0100, Alan Cox wrote:
> On Mer, 2006-05-10 at 07:31 -0700, Daniel Walker wrote:
> > > Hiding warnings like this can be a hazard as it will hide real warnings
> > > later on.
> > 
> > How could it hide real warnings? If anything these patch allow other
> > (real warnings) to be seen . 
> 
> Because while the warning is present people will check it now and again.

But it's pointless to review it, in this case and for this warning .

> If you set the variable to zero then you generate extra code and you
> ensure nobody will look in future.

The extra code is a problem , I'll admit that . But the warning should
disappear , it's just a waste .

Daniel

