Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932683AbWF1Bh3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932683AbWF1Bh3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 21:37:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932685AbWF1Bh3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 21:37:29 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:61629 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932683AbWF1Bh2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 21:37:28 -0400
Subject: Re: [RFC][PATCH 3/3] Process events biarch bug: New process events
	connector value
From: Matt Helsley <matthltc@us.ibm.com>
To: "Chandra S. Seetharaman" <sekharan@us.ibm.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
       Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
       Guillaume Thouvenin <guillaume.thouvenin@bull.net>,
       Michael Kerrisk <michael.kerrisk@gmx.net>
In-Reply-To: <1151452465.1412.35.camel@linuxchandra>
References: <20060627112644.804066367@localhost.localdomain>
	 <1151408975.21787.1815.camel@stark> <1151435679.1412.16.camel@linuxchandra>
	 <1151444382.21787.1858.camel@stark> <1151452465.1412.35.camel@linuxchandra>
Content-Type: text/plain
Date: Tue, 27 Jun 2006 18:29:11 -0700
Message-Id: <1151458151.21787.1913.camel@stark>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-06-27 at 16:54 -0700, Chandra Seetharaman wrote:
> On Tue, 2006-06-27 at 14:39 -0700, Matt Helsley wrote:
> > On Tue, 2006-06-27 at 12:14 -0700, Chandra Seetharaman wrote:
<snip>

> > > Is there a reason why the # of listeners part is removed (basically the
> > > LISTEN/IGNORE) ? and why as part of this patch ?
> > 
> > 	Michael Kerrisk had some objections to LISTEN/IGNORE and I've been
> > looking into making a connector function that would replace them. They
> > exist primarily to improve performance by avoiding the memory allocation
> > in cn_netlink_send() when there are no listeners.
> 
> If it not related this bug, can you please separate them.
> 
> <snip>

OK, I'll separate it for the next submission.

Cheers,
	-Matt Helsley

