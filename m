Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261461AbVEQNLH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261461AbVEQNLH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 09:11:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261498AbVEQNLG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 09:11:06 -0400
Received: from one.firstfloor.org ([213.235.205.2]:19075 "EHLO
	one.firstfloor.org") by vger.kernel.org with ESMTP id S261461AbVEQNKv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 09:10:51 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-cluster@redhat.com
Subject: Re: [PATCH 0/8] dlm: overview
References: <20050516071949.GE7094@redhat.com>
	<20050517001133.64d50d8c.akpm@osdl.org>
From: Andi Kleen <ak@muc.de>
Date: Tue, 17 May 2005 15:10:46 +0200
In-Reply-To: <20050517001133.64d50d8c.akpm@osdl.org> (Andrew Morton's
 message of "Tue, 17 May 2005 00:11:33 -0700")
Message-ID: <m1fywm80bt.fsf@muc.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:
>
> Squawk.
>
> Not only do I not know whether this stuff should be merged: I don't even
> know how to find that out.  Unless I'm prepared to become a full-on
> cluster/dlm person, which isn't looking likely.
>
> The usual fallback is to identify all the stakeholders and get them to say
> "yes Andrew, this code is cool and we can use it", but I don't think the
> clustering teams have sufficent act-togetherness to be able to do that.

My impression is that it is unlikely everybody will agree on a single
cluster setup anyways, so it might be best to use a similar strategy
as with file systems ("multiple implementations - standard API to the
outside world")

This would mean the DLM could be merged if the other cluster people
agree that the interface it presents to the outside world is good
for them too. Is it? Perhaps these interfaces should be discussed
first.

-Andi

