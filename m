Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261707AbUCBRLk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 12:11:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261712AbUCBRLk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 12:11:40 -0500
Received: from sb0-cf9a48a7.dsl.impulse.net ([207.154.72.167]:20878 "EHLO
	madrabbit.org") by vger.kernel.org with ESMTP id S261707AbUCBRLj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 12:11:39 -0500
Subject: Re: Desktop Filesystem Benchmarks in 2.6.3
From: Ray Lee <ray-lk@madrabbit.org>
To: pnelson@andrew.cmu.edu
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1078247497.1157.1886.camel@orca.madrabbit.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 02 Mar 2004 09:11:38 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey there,

> Based on these results I personally am now going with XFS as it's
> faster than ReiserFS in the real-world benchmarks and my current
> Ext3 partition's performance is getting worse and worse.

If your current Ext3 partition was created under 2.4.x, you may wish to
recreate it under 2.6. 2.6 uses a different algorithm to lay out
directory blocks (google on 'orlov allocator') and this can affect
performance.

                                  ~ ~

Nicely done, btw.

Ray

