Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262031AbUCLIUq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 03:20:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262043AbUCLIUq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 03:20:46 -0500
Received: from mx1.redhat.com ([66.187.233.31]:11715 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262031AbUCLIUp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 03:20:45 -0500
Date: Fri, 12 Mar 2004 08:22:14 +0000
From: Joe Thornber <thornber@redhat.com>
To: Andi Kleen <ak@muc.de>
Cc: Joe Thornber <thornber@redhat.com>, Mickael Marchand <marchand@kde.org>,
       linux-kernel@vger.kernel.org, dm@uk.sistina.com
Subject: Re: 2.6.4-mm1
Message-ID: <20040312082214.GO18345@reti>
References: <1ysXv-wm-11@gated-at.bofh.it> <1yxuq-6y6-13@gated-at.bofh.it> <m3hdwnawfi.fsf@averell.firstfloor.org> <200403111445.35075.marchand@kde.org> <20040311144829.GA22284@colin2.muc.de> <20040311214354.GM18345@reti> <20040311233720.GB46488@colin2.muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040311233720.GB46488@colin2.muc.de>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 12, 2004 at 12:37:20AM +0100, Andi Kleen wrote:
> Are DM_NAME_LEN and DM_UUID_LEN not both a multiple of 8?

name len == 128, uuid_len == 129, so is the uuid_len being rounded up
to the nearest 64bit boundary on x86-64 and only 32bit boundary on
x86-32 ?  (Sounds likely)

> There are more structures here, right?

Not that effect this problem, we're getting unknown ioctl, not an oops.

- Joe
