Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266871AbUAXGAM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jan 2004 01:00:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266872AbUAXGAL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jan 2004 01:00:11 -0500
Received: from holomorphy.com ([199.26.172.102]:61072 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S266871AbUAXGAH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jan 2004 01:00:07 -0500
Date: Fri, 23 Jan 2004 22:00:03 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: john moser <bluefoxicy@linux.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: shmat -- wtf owns it?
Message-ID: <20040124060003.GA1025@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	john moser <bluefoxicy@linux.net>, linux-kernel@vger.kernel.org
References: <20040124055328.008343950@sitemail.everyone.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040124055328.008343950@sitemail.everyone.net>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 23, 2004 at 09:53:28PM -0800, john moser wrote:
> Okay I've been back and forth through ipc/shm.c and shm.h about 3 or
> 4 times. Yes, rather cursory of me to not read it 40 times.  But,
> seriously.
> Who the FUCK owns a shm segment?  I can't see a way to check the
> creator of a segment of shm in sys_shmat() in ipc/shm.c and I really
> tried too.

There are uid's and gid's associated with shm segments.

c.f. struct ipc_perm


-- wli
