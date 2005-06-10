Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262572AbVFJPSq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262572AbVFJPSq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 11:18:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262573AbVFJPSp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 11:18:45 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:53681 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S262572AbVFJPS0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 11:18:26 -0400
Subject: Re: RFC: i386: kill !4KSTACKS
From: Vladimir Saveliev <vs@namesys.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       "reiserfs-dev@namesys.com" <reiserfs-dev@namesys.com>
In-Reply-To: <1118232016.3176.72.camel@tribesman.namesys.com>
References: <20050607212706.GB7962@stusta.de>
	 <1118232016.3176.72.camel@tribesman.namesys.com>
Content-Type: text/plain
Message-Id: <1118416683.11339.94.camel@tribesman.namesys.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Fri, 10 Jun 2005 19:18:04 +0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

On Wed, 2005-06-08 at 16:00, Vladimir Saveliev wrote:
> Hello
> 
> On Wed, 2005-06-08 at 01:27, Adrian Bunk wrote:
> > 4Kb kernel stacks are the future on i386, and it seems the problems it 
> > initially caused are now sorted out.
> > 
> > I'd like to:
> > - get a patch into the next -mm that unconditionally enables 4KSTACKS
> > - if there won't be new reports of breakages, send a patch to
> >   completely remove !4KSTACKS for 2.6.13 or 2.6.14
> > 
> > The only drawback is that REISER4_FS does still depend on !4KSTACKS.
> > I told Hans back in March that this has to be changed.
> > Is there any ETA until that all issues with 4Kb kernel stacks in Reiser4 
> > will be resolved?
> > 
> 
> yes, it should be ready to the end of this week.
> 
Well, this estimation was too optimistic.
I have some progress on this but this work is not yet completed. It
continues. New estimation is the middle of next week.

> 
> > If not people using Reiser4 might have to decide whether to switch the 
> > filesystem or the architecture...
> > 
> > cu
> > Adrian

