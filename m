Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261410AbUKERsL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261410AbUKERsL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 12:48:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261386AbUKERsL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 12:48:11 -0500
Received: from grendel.digitalservice.pl ([217.67.200.140]:34189 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S261410AbUKERsH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 12:48:07 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-rc1-mm3
Date: Fri, 5 Nov 2004 18:47:29 +0100
User-Agent: KMail/1.6.2
Cc: Andi Kleen <ak@suse.de>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>
References: <20041105001328.3ba97e08.akpm@osdl.org> <200411051357.12599.rjw@sisk.pl> <20041105130205.GG8349@wotan.suse.de>
In-Reply-To: <20041105130205.GG8349@wotan.suse.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Message-Id: <200411051847.29814.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 05 of November 2004 14:02, Andi Kleen wrote:
> On Fri, Nov 05, 2004 at 01:57:12PM +0100, Rafael J. Wysocki wrote:
> > On Friday 05 of November 2004 13:22, Andi Kleen wrote:
> > > On Fri, Nov 05, 2004 at 01:15:28PM +0100, Ingo Molnar wrote:
> > > > 
> > > > next problem: the x64 kernel doesnt boot 32-bit userspace anymore. I'm 
> > > > getting an endless stream of segfaults:
> > > 
> > > I bet that is caused by the flexmmap TASK_SIZE changes.  Can you revert
> > > the 64bit flexmmap patch and see if that helps? 
> > > 
> > > I tested it before flexmmap and it worked for me.
> > 
> > If it's not changed from the version that went to discuss@x86-64.org, 
flexmmap 
> > breaks 32-bit user land on x86-64.  I've already reported it.
> 
> It didn't for me when I tested it without 4levels.

Well, for me it did, on two different boxes, with defconfig, so I think 
there's at least something wrong with it.

Greets,
RJW

-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
