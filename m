Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262109AbUFRU6C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262109AbUFRU6C (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 16:58:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263028AbUFRU5X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 16:57:23 -0400
Received: from cfcafw.sgi.com ([198.149.23.1]:58910 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S262109AbUFRUz7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 16:55:59 -0400
Date: Fri, 18 Jun 2004 15:55:58 -0500
From: Brent Casavant <bcasavan@sgi.com>
Reply-To: Brent Casavant <bcasavan@sgi.com>
To: Martin Josefsson <gandalf@wlug.westbo.se>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add kallsyms_lookup() result cache
In-Reply-To: <1087591028.1019.77.camel@tux.rsn.bth.se>
Message-ID: <Pine.SGI.4.58.0406181554280.5029@kzerza.americas.sgi.com>
References: <Pine.SGI.4.58.0406181435570.5029@kzerza.americas.sgi.com>
 <1087591028.1019.77.camel@tux.rsn.bth.se>
Organization: "Silicon Graphics, Inc."
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Jun 2004, Martin Josefsson wrote:

> On Fri, 2004-06-18 at 22:03, Brent Casavant wrote:
>
> Hi Brent
>
> just something that cought my eye.
>
> > +static rwlock_t namecache_lock;
>
> should be
>
> static rwlock_t namecache_lock = RW_LOCK_UNLOCKED;

Ah, thank you.  Fixed.  I'll queue up any other catches before resending.

Thanks,
Brent

-- 
Brent Casavant             bcasavan@sgi.com        Forget bright-eyed and
Operating System Engineer  http://www.sgi.com/     bushy-tailed; I'm red-
Silicon Graphics, Inc.     44.8562N 93.1355W 860F  eyed and bushy-haired.
