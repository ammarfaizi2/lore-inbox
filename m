Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932246AbWG2UzZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932246AbWG2UzZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jul 2006 16:55:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932243AbWG2UzY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jul 2006 16:55:24 -0400
Received: from alnrmhc11.comcast.net ([204.127.225.91]:45994 "EHLO
	alnrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S932244AbWG2UzX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jul 2006 16:55:23 -0400
Subject: Re: [RFC 1/4] kevent: core files.
From: Nicholas Miell <nmiell@comcast.net>
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Cc: Ulrich Drepper <drepper@redhat.com>, Zach Brown <zach.brown@oracle.com>,
       David Miller <davem@davemloft.net>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
In-Reply-To: <20060729154817.GB25926@2ka.mipt.ru>
References: <20060724.231708.01289489.davem@davemloft.net>
	 <44C91192.4090303@oracle.com> <20060727200655.GA4586@2ka.mipt.ru>
	 <44C930D5.9020704@oracle.com> <20060728052312.GB11210@2ka.mipt.ru>
	 <44CA586C.4010205@oracle.com> <20060728184445.GA10797@2ka.mipt.ru>
	 <44CA613F.9080806@oracle.com> <44CAD81A.9060401@redhat.com>
	 <1154147562.2451.30.camel@entropy>  <20060729154817.GB25926@2ka.mipt.ru>
Content-Type: text/plain
Date: Sat, 29 Jul 2006 13:54:51 -0700
Message-Id: <1154206491.2467.3.camel@entropy>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5.0.njm.1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-07-29 at 19:48 +0400, Evgeniy Polyakov wrote:
> On Fri, Jul 28, 2006 at 09:32:42PM -0700, Nicholas Miell (nmiell@comcast.net) wrote:
> > Speaking of API design choices, I saw your OLS paper and was wondering
> > if you were familiar with the Solaris port APIs* and, if so, you could
> > please comment on how your proposed event channels are different/better.
> 
> As far as it concerns kevents - userspace "ports" are just usual users
> of kevents, like timer notifications. Add another syscall to "complete"
> requested kevents and you get exactly Solaris ports.
> It is fairly simple to implement on top of kevents, I just do not see
> immediate benefits from that.
> 

Sorry, I wasn't talking about kevent, I was talking about the interfaces
described in "The Need for Asynchronous, Zero-Copy Network I/O" by
Ulrich Drepper -- specifically the ec_t type and related functions and
the modifications to struct sigevent.

-- 
Nicholas Miell <nmiell@comcast.net>

