Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263975AbUFVOIB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263975AbUFVOIB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 10:08:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263806AbUFVOHf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 10:07:35 -0400
Received: from [80.72.36.106] ([80.72.36.106]:13965 "EHLO alpha.polcom.net")
	by vger.kernel.org with ESMTP id S263810AbUFVOBN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 10:01:13 -0400
Date: Tue, 22 Jun 2004 16:01:07 +0200 (CEST)
From: Grzegorz Kulewski <kangur@polcom.net>
To: Stewart Smith <stewart@flamingspork.com>
Cc: Chris Wright <chrisw@osdl.org>, Bob Gill <gillb4@telusplanet.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       akepner@sgi.com
Subject: Re: [2.6.7-bk] NFS-related kernel panic
In-Reply-To: <1087911479.4691.4.camel@kennedy>
Message-ID: <Pine.LNX.4.58.0406221559530.7906@alpha.polcom.net>
References: <1087872607.4066.13.camel@localhost.localdomain> 
 <20040621203520.H22989@build.pdx.osdl.net> <1087911479.4691.4.camel@kennedy>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Unfortunatelly this does not fix my (similar?) problem described in 
"Network related(?) kernel panic (2.6.7-bk4)".


Thanks,

Grzegorz Kulewski


On Tue, 22 Jun 2004, Stewart Smith wrote:

> On Tue, 2004-06-22 at 13:35, Chris Wright wrote:
> > > bad: scheduling while atomic!
> > The lockless loopback transmission patch mucks up the preempt count.
> > Can you give this patch a try?
> 
> This seems to fix the problem, thanks.
> 
> -- 
> Stewart Smith (stewart@flamingspork.com)
> http://www.flamingspork.com/
> 
> 
