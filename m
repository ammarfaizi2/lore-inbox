Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422738AbWF0Xy3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422738AbWF0Xy3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 19:54:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422740AbWF0Xy3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 19:54:29 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:29350 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1422738AbWF0Xy2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 19:54:28 -0400
Subject: Re: [RFC][PATCH 3/3] Process events biarch bug: New process events
	connector value
From: Chandra Seetharaman <sekharan@us.ibm.com>
Reply-To: sekharan@us.ibm.com
To: Matt Helsley <matthltc@us.ibm.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
       Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
       Guillaume Thouvenin <guillaume.thouvenin@bull.net>,
       Michael Kerrisk <michael.kerrisk@gmx.net>
In-Reply-To: <1151444382.21787.1858.camel@stark>
References: <20060627112644.804066367@localhost.localdomain>
	 <1151408975.21787.1815.camel@stark> <1151435679.1412.16.camel@linuxchandra>
	 <1151444382.21787.1858.camel@stark>
Content-Type: text/plain
Organization: IBM
Date: Tue, 27 Jun 2006 16:54:25 -0700
Message-Id: <1151452465.1412.35.camel@linuxchandra>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-06-27 at 14:39 -0700, Matt Helsley wrote:
> On Tue, 2006-06-27 at 12:14 -0700, Chandra Seetharaman wrote:
> > On Tue, 2006-06-27 at 04:49 -0700, Matt Helsley wrote:
> > > "Deprecate" existing Process Events connector interface and add a new one
> > > that works cleanly on biarch platforms.
> > > 
> > > Any expansion of the previous event structure would break userspace's ability
> > > to workaround the biarch incompatibility problem. Hence this patch creates a
> > > new interface and generates events (for both when necessary).
> > 
> > Is there a reason why the # of listeners part is removed (basically the
> > LISTEN/IGNORE) ? and why as part of this patch ?
> 
> 	Michael Kerrisk had some objections to LISTEN/IGNORE and I've been
> looking into making a connector function that would replace them. They
> exist primarily to improve performance by avoiding the memory allocation
> in cn_netlink_send() when there are no listeners.

If it not related this bug, can you please separate them.

<snip>
-- 

----------------------------------------------------------------------
    Chandra Seetharaman               | Be careful what you choose....
              - sekharan@us.ibm.com   |      .......you may get it.
----------------------------------------------------------------------


