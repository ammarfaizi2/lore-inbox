Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266580AbUFWRCZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266580AbUFWRCZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 13:02:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266560AbUFWRCZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 13:02:25 -0400
Received: from h-68-165-86-241.dllatx37.covad.net ([68.165.86.241]:24920 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP id S266585AbUFWRCG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 13:02:06 -0400
Subject: Re: 2.6.7-bk5 scheduling while atomic
From: Paul Fulghum <paulkf@microgate.com>
To: Christian Kujau <evil@g-house.de>
Cc: Klaus Dittrich <kladit@t-online.de>,
       linux mailing-list <linux-kernel@vger.kernel.org>
In-Reply-To: <40D864BF.9000304@g-house.de>
References: <20040622135529.GA838@xeon2.local.here>
	 <40D864BF.9000304@g-house.de>
Content-Type: text/plain
Organization: 
Message-Id: <1088010119.2017.1.camel@deimos.microgate.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 23 Jun 2004 12:01:59 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-06-22 at 11:56, Christian Kujau wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Klaus Dittrich wrote:
> > System smp (2 x XEON, I7505) preemptive
> >
> > With kernel-2.6.7-bk5 I get a lot of
> > "kernel: bad: scheduling while atomic!" messages
> > during startup.
> >
> > 2.6.7 runs fine using the basically the same configuration.
> >
> > Did anybody else see this ?

> yes, "me too". but i was not able to get the messages flushed to the
> disk. this is 2.6.7-BK kernel from 2004-06-21 (around 4p.m., GMT+1).

2.6.7-bk6 fixes it for me.

--
Paul Fulghum
paulkf@microgate.com


