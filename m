Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261528AbUEJU3k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261528AbUEJU3k (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 16:29:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261576AbUEJU3k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 16:29:40 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:38016 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261528AbUEJU3c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 16:29:32 -0400
Date: Mon, 10 May 2004 13:28:49 -0700
From: Paul Jackson <pj@sgi.com>
To: Silviu Marin-Caea <silviu@genesys.ro>
Cc: linux-kernel@vger.kernel.org, John Bradford <john@grabjohn.com>
Subject: Re: dynamic allocation of swap disk space
Message-Id: <20040510132849.435b6b26.pj@sgi.com>
In-Reply-To: <409F57F1.2060803@genesys.ro>
References: <33073.192.168.1.88.1084179033.squirrel@mail.genesys.ro>
	<200405101003.i4AA3uJt000135@81-2-122-30.bradfords.org.uk>
	<409F57F1.2060803@genesys.ro>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> How about dynamically allocating up to a certain limit.

Given that disk space is essentially "free", how does that
differ from simply allocating swap files up to the desired
limit size?

And having a bigger swap space wouldn't help your thrashing
problem.  You're not thrashing (unusable system, mucho disk
activity) for lack of swap space.  You're thrashing because
you are trying to use the swap space you already have for
active pages.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
