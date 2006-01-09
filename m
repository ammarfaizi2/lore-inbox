Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750718AbWAIV2Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750718AbWAIV2Y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 16:28:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750719AbWAIV2X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 16:28:23 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:8915 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750718AbWAIV2X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 16:28:23 -0500
Subject: Re: [PATCH updated]: How to be a kernel driver maintainer
From: Arjan van de Ven <arjan@infradead.org>
To: Ben Collins <ben.collins@ubuntu.com>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <1136813649.1043.30.camel@grayson>
References: <1136736455.24378.3.camel@grayson>
	 <1136756756.1043.20.camel@grayson>
	 <1136792769.2936.13.camel@laptopd505.fenrus.org>
	 <1136813649.1043.30.camel@grayson>
Content-Type: text/plain
Date: Mon, 09 Jan 2006 22:28:20 +0100
Message-Id: <1136842100.2936.34.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.8 (--)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (-2.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-01-09 at 08:34 -0500, Ben Collins wrote:
> On Mon, 2006-01-09 at 08:46 +0100, Arjan van de Ven wrote:
> > On Sun, 2006-01-08 at 16:45 -0500, Ben Collins wrote:
> > > Here's an updated document. I integrated the suggestions. For Arjan, I
> > > added a new section at the end. Hopefully that addresses the concerns
> > > for cvs-mentality.
> > 
> > it doesn't enough ;(
> > 
> > you still do a major suggestion to keep the code in a repo outside the
> > kernel. For a single driver really that's at best "optional" and
> > shouldn't be the prime recommendation. 
> > 
> > "If your driver is affected, you are expected to pick up these changes
> > and merge them with your primary code (e.g. if you have a CVS repo for
> > maintaining your code)."
> > 
> > that sentence is just really the one that I hate. It's bogus. It still
> > calls the private CVS copy "primary".
> > If you do the right thing (and store deltas against mainline and not
> > full code except for scratch stuff) then this is no question of "merging
> > back from mainline" at all. 
> 
> But it says "your primary code". I'm not sure of another way to put it.

"your temporary development copy"

> Obviously, they have to do their work, and their development on
> something that isn't in Linus tree. If they are doing this work, they
> need to make sure that when they diff for patches, that they merge
> changes before diffing. The only way this is close to automatic is with
> git. Any other method requires manually merging.

not correct. quilt is a very excellent counter example of that.



