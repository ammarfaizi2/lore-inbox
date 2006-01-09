Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751456AbWAINex@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751456AbWAINex (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 08:34:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932143AbWAINex
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 08:34:53 -0500
Received: from a34-mta01.direcpc.com ([66.82.4.90]:26670 "EHLO
	a34-mta01.direcway.com") by vger.kernel.org with ESMTP
	id S1751465AbWAINew (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 08:34:52 -0500
Date: Mon, 09 Jan 2006 08:34:09 -0500
From: Ben Collins <ben.collins@ubuntu.com>
Subject: Re: [PATCH updated]: How to be a kernel driver maintainer
In-reply-to: <1136792769.2936.13.camel@laptopd505.fenrus.org>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Message-id: <1136813649.1043.30.camel@grayson>
Organization: Ubuntu Linux
MIME-version: 1.0
X-Mailer: Evolution 2.5.3
Content-type: text/plain
Content-transfer-encoding: 7BIT
References: <1136736455.24378.3.camel@grayson>
 <1136756756.1043.20.camel@grayson>
 <1136792769.2936.13.camel@laptopd505.fenrus.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-01-09 at 08:46 +0100, Arjan van de Ven wrote:
> On Sun, 2006-01-08 at 16:45 -0500, Ben Collins wrote:
> > Here's an updated document. I integrated the suggestions. For Arjan, I
> > added a new section at the end. Hopefully that addresses the concerns
> > for cvs-mentality.
> 
> it doesn't enough ;(
> 
> you still do a major suggestion to keep the code in a repo outside the
> kernel. For a single driver really that's at best "optional" and
> shouldn't be the prime recommendation. 
> 
> "If your driver is affected, you are expected to pick up these changes
> and merge them with your primary code (e.g. if you have a CVS repo for
> maintaining your code)."
> 
> that sentence is just really the one that I hate. It's bogus. It still
> calls the private CVS copy "primary".
> If you do the right thing (and store deltas against mainline and not
> full code except for scratch stuff) then this is no question of "merging
> back from mainline" at all. 

But it says "your primary code". I'm not sure of another way to put it.
Obviously, they have to do their work, and their development on
something that isn't in Linus tree. If they are doing this work, they
need to make sure that when they diff for patches, that they merge
changes before diffing. The only way this is close to automatic is with
git. Any other method requires manually merging.

How else would you explain this without telling them that git is
required?

-- 
   Ben Collins <ben.collins@ubuntu.com>
   Developer
   Ubuntu Linux

