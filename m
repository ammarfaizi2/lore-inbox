Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262762AbULQHrO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262762AbULQHrO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 02:47:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262763AbULQHrN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 02:47:13 -0500
Received: from amsfep13-int.chello.nl ([213.46.243.23]:44561 "EHLO
	amsfep13-int.chello.nl") by vger.kernel.org with ESMTP
	id S262762AbULQHrL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 02:47:11 -0500
Subject: Re: all three IO Schedulers turned on in 2.6.10-rc3-mm1 ???
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: "Steven A. DuChene" <sduchene@mindspring.com>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20041216141018.D927@lapsony.sc04.org>
References: <20041216141018.D927@lapsony.sc04.org>
Content-Type: text/plain
Date: Fri, 17 Dec 2004 08:35:40 +0100
Message-Id: <1103268940.6325.6.camel@twins>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-12-16 at 14:10 -0500, Steven A. DuChene wrote:
> I downloaded and built the 2.6.10-rc3-mm1 kernel and I noticed while
> configuring it that in the Device Drivers > Block devices > IO Schedulers
> area that by default all three IO Schedulers are turned on. Is this a
> normal condition or is there only supposed to be one of these turned on?
> 
yes, you can change them runtime in /sys/block/<dev>/queue/scheduler

> The reason I am concerned about this is that ever since I have booted
> into this kernel I have a lot of things failing and when they fail
> they return a message like "Inappropriate ioctl for device"
> 
see:
	http://lkml.org/lkml/2004/12/13/69

> I get this when trying to do a simple wget (remote address fails to resolve)
> and when trying to run any X program against the Xserver running on the system.
-- 
Peter Zijlstra <a.p.zijlstra@chello.nl>

