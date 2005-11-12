Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932446AbVKLSRY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932446AbVKLSRY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Nov 2005 13:17:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932447AbVKLSRY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Nov 2005 13:17:24 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:44007 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S932446AbVKLSRY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Nov 2005 13:17:24 -0500
Date: Sat, 12 Nov 2005 10:17:00 -0800
From: Paul Jackson <pj@sgi.com>
To: bob.picco@hp.com
Cc: akpm@osdl.org, simon.derr@bull.net, linux-kernel@vger.kernel.org,
       bob.picco@hp.com
Subject: Re: [PATCH] cpuset - fix return without releasing semaphore
Message-Id: <20051112101700.2cd75b59.pj@sgi.com>
In-Reply-To: <20051112022122.22085.45247.sendpatchset@localhost.localdomain>
References: <20051112022122.22085.45247.sendpatchset@localhost.localdomain>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bob wrote:
> It seems wrong to acquire the semaphore and then return from 
> cpuset_zone_allowed without releasing it.  This was only compile tested.

Acked-by: Paul Jackson <pj@sgi.com>

Nice catch, Bob.  Thanks.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
