Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932468AbVKLT0x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932468AbVKLT0x (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Nov 2005 14:26:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932472AbVKLT0x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Nov 2005 14:26:53 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:4287 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932468AbVKLT0x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Nov 2005 14:26:53 -0500
Date: Sat, 12 Nov 2005 11:26:28 -0800
From: Paul Jackson <pj@sgi.com>
To: bob.picco@hp.com
Cc: akpm@osdl.org, simon.derr@bull.net, linux-kernel@vger.kernel.org,
       bob.picco@hp.com
Subject: Re: [PATCH] cpuset - fix return without releasing semaphore
Message-Id: <20051112112628.22aaa314.pj@sgi.com>
In-Reply-To: <20051112022122.22085.45247.sendpatchset@localhost.localdomain>
References: <20051112022122.22085.45247.sendpatchset@localhost.localdomain>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This was only compile tested.

I boot, function and stress tested it on an ia64 SN2 system.
As expected, works fine, just as it did before.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
