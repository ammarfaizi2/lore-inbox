Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262177AbTFKOvb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 10:51:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262192AbTFKOva
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 10:51:30 -0400
Received: from smtp.bitmover.com ([192.132.92.12]:29420 "EHLO
	smtp.bitmover.com") by vger.kernel.org with ESMTP id S262177AbTFKOv3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 10:51:29 -0400
Date: Wed, 11 Jun 2003 08:05:06 -0700
From: Larry McVoy <lm@bitmover.com>
To: Ben Collins <bcollins@debian.org>
Cc: Pascal Schmidt <der.eremit@email.de>, Larry McVoy <lm@bitmover.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [BK-CVS gateway] version tags
Message-ID: <20030611150506.GB20493@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Ben Collins <bcollins@debian.org>,
	Pascal Schmidt <der.eremit@email.de>, Larry McVoy <lm@bitmover.com>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0306111641140.1602-100000@neptune.local> <20030611135910.GO4695@phunnypharm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030611135910.GO4695@phunnypharm.org>
User-Agent: Mutt/1.4i
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=0.3,
	required 7, AWL)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 11, 2003 at 09:59:10AM -0400, Ben Collins wrote:
> On Wed, Jun 11, 2003 at 04:44:37PM +0200, Pascal Schmidt wrote:
> > 
> > Hi!
> > 
> > I noticed both the 2.4 and 2.5 BK->CVS trees don't have version tags
> > any more (v2_5_70, for example, as in the old tree).
> > 
> > Is this intentional? Did CVS take too long to tag all files or something?
> > 
> > It was quite a nice feature to have them, very useful for finding out the
> > differences between certain kernel versions. I can live without it, 
> > though. It's still a nice service without the tags. (Thanks!)
> 
> Looks like the tags are on the ChangeSet file only. Which is why I
> didn't notice. You could get a timestamp from the tag on ChangeSet and
> use that for a -D argument.
> 
> A quick script could do this for you. I think it's wise of Larry to keep
> it this way.

"Wise" is a stretch, more like a fortunate scripting screwup.  But I agree
with Ben, given that you can get the info another way it is a lot easier
(i.e., thrashes the disk less) if we leave it as is.
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
