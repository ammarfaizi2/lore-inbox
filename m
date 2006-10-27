Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750897AbWJ0Xen@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750897AbWJ0Xen (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 19:34:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750893AbWJ0Xen
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 19:34:43 -0400
Received: from agminet01.oracle.com ([141.146.126.228]:42363 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1750732AbWJ0Xen (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 19:34:43 -0400
Message-ID: <4542977E.5030007@oracle.com>
Date: Fri, 27 Oct 2006 16:34:22 -0700
From: Zach Brown <zach.brown@oracle.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Jeff Moyer <jmoyer@redhat.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dio: lock refcount operations
References: <20061027181735.18631.43565.sendpatchset@tetsuo.zabbo.net>	<x49fyd9v9sy.fsf@segfault.boston.devel.redhat.com>	<45426D3F.3040304@oracle.com> <x49odrxnyyt.fsf@segfault.boston.devel.redhat.com>
In-Reply-To: <x49odrxnyyt.fsf@segfault.boston.devel.redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> zach.brown> The addition of the interrupt masking spin lock acquiry in
> zach.brown> dio_bio_submit() looks alarming.  This lock acquiry existed in
> zach.brown> that path before the recent dio completion patch set.  We
> zach.brown> shouldn't expect significant performance regression from
> zach.brown> returning to the behaviour that existed before the completion
> zach.brown> clean up work. 
> 
> Are you going to quantify this at all?  I think we should.

I could try to take a swing at it next week, sure.

Leaving it for Ken is pretty tempting, though :)

- z
