Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267538AbUHTAXZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267538AbUHTAXZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 20:23:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267540AbUHTAXZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 20:23:25 -0400
Received: from mail.enyo.de ([212.9.189.167]:41998 "EHLO mail.enyo.de")
	by vger.kernel.org with ESMTP id S267538AbUHTAXX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 20:23:23 -0400
To: Miles Lane <miles.lane@comcast.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: DTrace-like analysis possible with future Linux kernels?
References: <200408191822.48297.miles.lane@comcast.net>
	<87hdqyogp4.fsf@killer.ninja.frodoid.org>
From: Florian Weimer <fw@deneb.enyo.de>
Date: Fri, 20 Aug 2004 02:23:22 +0200
In-Reply-To: <87hdqyogp4.fsf@killer.ninja.frodoid.org> (Julien Oster's message
	of "Fri, 20 Aug 2004 01:23:35 +0200")
Message-ID: <87k6vu3bet.fsf@deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Julien Oster:

> Miles Lane <miles.lane@comcast.net> writes:
>
>> http://www.theregister.co.uk/2004/07/08/dtrace_user_take/:
>> "Sun sees DTrace as a big advantage for Solaris over other versions of Unix 
>> and Linux."
>
> That article is way too hypey.

Maybe, but DTrace seems to solve one really pressing problem: tracking
disk I/O to the processes causing it.  Unexplained high I/O
utilization is a *very* common problem, and there aren't any tools to
diagnose it.

Most other system resources can be tracked quite easily: disk space,
CPU time, committed address space, even network I/O (with tcpdump and
netstat -p).  But there's no such thing for disk I/O.
