Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261177AbVCXWcO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261177AbVCXWcO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 17:32:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261183AbVCXWcN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 17:32:13 -0500
Received: from grendel.digitalservice.pl ([217.67.200.140]:1154 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S261177AbVCXWbq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 17:31:46 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc1-mm2
Date: Thu, 24 Mar 2005 23:31:46 +0100
User-Agent: KMail/1.7.1
Cc: Andrew Morton <akpm@osdl.org>, Lee Revell <rlrevell@joe-job.com>,
       alsa-devel@lists.sourceforge.net
References: <20050324044114.5aa5b166.akpm@osdl.org> <1111682812.23440.6.camel@mindpipe> <20050324121722.759610f4.akpm@osdl.org>
In-Reply-To: <20050324121722.759610f4.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503242331.46985.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thursday, 24 of March 2005 21:17, Andrew Morton wrote:
> Lee Revell <rlrevell@joe-job.com> wrote:
> >
> > On Thu, 2005-03-24 at 04:41 -0800, Andrew Morton wrote:
> > >   -mm kernels now aggregate Linus's tree and 34 subsystem trees.  Usually
> > >   they are pulled 3-4 hours before the release of the -mm kernel.  
> > > 
> > 
> > Andrew,
> > 
> > Do you notify the subsystem maintainers ahead of time so that critical
> > fixes can be pushed to BK?
> 
> Occasionally I'll go out and ping people, but almost always the subsystem
> guys know what the development cycle is, and they appropriately decide
> which code should go in, and when.
> 
> > I am thinking of the recent ALSA example, where the emu10k1 driver was
> > b0rked in 2.6.12-mm1, but the fix had been in ALSA CVS for a week.
> > 
> 
> We've been discussing how to get ALSA CVS into ALSA bk more promptly.

BTW, on 2.6.12-rc1-mm2 I can't rmmod the snd_intel8x0 module (the process
goes into the D state immediately), which did not happen before.  This is 100%
reproducible, on two different AMD64-based boxes, with different sound chips.

Greets,
Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
