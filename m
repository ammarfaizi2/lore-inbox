Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266863AbUGVFWw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266863AbUGVFWw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jul 2004 01:22:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266869AbUGVFWw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jul 2004 01:22:52 -0400
Received: from mx1.redhat.com ([66.187.233.31]:10959 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266863AbUGVFWv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jul 2004 01:22:51 -0400
Date: Thu, 22 Jul 2004 01:22:03 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@devserv.devel.redhat.com
To: dpf-lkml@fountainbay.com
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Delete cryptoloop
In-Reply-To: <4411.24.6.231.172.1090470409.squirrel@24.6.231.172>
Message-ID: <Pine.LNX.4.58.0407220110290.20963@devserv.devel.redhat.com>
References: <Pine.LNX.4.58.0407211609230.19655@devserv.devel.redhat.com>   
 <20040721230044.20fdc5ec.akpm@osdl.org> <4411.24.6.231.172.1090470409.squirrel@24.6.231.172>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Jul 2004 dpf-lkml@fountainbay.com wrote:

> Ditching cryptoloop completely in 2.7 after dm-crypt matures would be a
> better idea.

Part of the reason for dropping cryptoloop is to help dm-crypt mature more 
quickly.

I've had some off-list email on the security of dm-crypt, and it seems
that it does need some work.  We need to get the security right more than 
we need to worry about these other issues.

Let's drop the technically inferior of the two (cryptoloop) and
concentrate on fixing the other (dm-crypt).

There was a thread on redesigning the security a while back (subject:
"dm-crypt, new IV and standards"), but no code came out of it.  Anyone 
interested should probably have a look at that.


- James
-- 
James Morris
<jmorris@redhat.com>
