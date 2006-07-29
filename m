Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751990AbWG2Poe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751990AbWG2Poe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jul 2006 11:44:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751947AbWG2Poe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jul 2006 11:44:34 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:26596 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S1751164AbWG2Pod (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jul 2006 11:44:33 -0400
Date: Sat, 29 Jul 2006 19:44:01 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Ulrich Drepper <drepper@redhat.com>
Cc: Zach Brown <zach.brown@oracle.com>, David Miller <davem@davemloft.net>,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [RFC 1/4] kevent: core files.
Message-ID: <20060729154401.GA25926@2ka.mipt.ru>
References: <20060709132446.GB29435@2ka.mipt.ru> <20060724.231708.01289489.davem@davemloft.net> <44C91192.4090303@oracle.com> <20060727200655.GA4586@2ka.mipt.ru> <44C930D5.9020704@oracle.com> <20060728052312.GB11210@2ka.mipt.ru> <44CA586C.4010205@oracle.com> <20060728184445.GA10797@2ka.mipt.ru> <44CA613F.9080806@oracle.com> <44CAD81A.9060401@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <44CAD81A.9060401@redhat.com>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Sat, 29 Jul 2006 19:44:02 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 28, 2006 at 08:38:02PM -0700, Ulrich Drepper (drepper@redhat.com) wrote:
> Zach Brown wrote:
> > Ulrich, would you be satisfied if we didn't
> > have the userspace mapped ring on the first pass and only had a
> > collection syscall?
> 
> I'm not the one to make a call but why rush things?  Let's do it right
> from the start.  Later changes can only lead to problems with users of
> the earlier interface.

Btw, why do we want mapped ring of ready events?
If user requestd some event, he definitely wants to get them back when
they are ready, and not to check and then get them?
Could you please explain more on this issue?

> -- 
> ??? Ulrich Drepper ??? Red Hat, Inc. ??? 444 Castro St ??? Mountain View, CA ???
> 



-- 
	Evgeniy Polyakov
