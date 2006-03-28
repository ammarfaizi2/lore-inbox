Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751148AbWC1Psm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751148AbWC1Psm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 10:48:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751164AbWC1Psm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 10:48:42 -0500
Received: from web37708.mail.mud.yahoo.com ([209.191.87.106]:34977 "HELO
	web37708.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751148AbWC1Psl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 10:48:41 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=0x3t+coisvphbgWO4RA/kArAl7HiSkhWnN3oXE0YMmb8v88eBgqRonIkZhuxry45Wa22e554MYT+MqNrZBS+vvRSDs81aCDS4qGBMzJcysnqSHm0H1mKpRQbCZ3NJDxEYFdR1WN/GCxHQ5VkcjN5/tUsd/4wv6/rjbYJUOrP/VU=  ;
Message-ID: <20060328154841.74612.qmail@web37708.mail.mud.yahoo.com>
Date: Tue, 28 Mar 2006 07:48:41 -0800 (PST)
From: Edward Chernenko <edwardspec@yahoo.com>
Subject: Re: [PATCH 2.6.15] Adding kernel-level identd dispatcher
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: linux-kernel@vger.kernel.org, edwardspec@gmail.com
In-Reply-To: <1143552990.8009.27.camel@lade.trondhjem.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--- Trond Myklebust <trond.myklebust@fys.uio.no>
wrote:

> Most servers are designed for low latency. A lot of
> them sleep a lot,
> and a fair number of them also go poking around the
> kernel variables
> in /proc (which exists precisely in order to export
> internal kernel
> variables to userspace programs). I'll bet even your
> average Oracle
> database application fits those criteria.
> 
> Echo made sense to move into the kernel because in
> addition to the above
> it is a required feature on all Internet hosts, is
> pretty much stateless
> (and/or depends only on internal IP stack state),
> and needs extra low
> latency because it is designed to be used for timing
> purposes by
> clients.
> The same criteria hardly apply to identd.

If so, then why khttpd _was_ included into kernel?

Edward Chernenko <edwardspec@gmail.com>

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
