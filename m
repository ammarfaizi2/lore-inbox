Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267191AbUGVUCb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267191AbUGVUCb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jul 2004 16:02:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267193AbUGVUCb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jul 2004 16:02:31 -0400
Received: from fw.osdl.org ([65.172.181.6]:39358 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267191AbUGVUC2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jul 2004 16:02:28 -0400
Date: Thu, 22 Jul 2004 16:01:12 -0700
From: Andrew Morton <akpm@osdl.org>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: corbet@lwn.net, linux-kernel@vger.kernel.org
Subject: Re: New dev model (was [PATCH] delete devfs)
Message-Id: <20040722160112.177fc07f.akpm@osdl.org>
In-Reply-To: <20040722193337.GE19329@fs.tum.de>
References: <40FEEEBC.7080104@quark.didntduck.org>
	<20040721231123.13423.qmail@lwn.net>
	<20040721235228.GZ14733@fs.tum.de>
	<20040722025539.5d35c4cb.akpm@osdl.org>
	<20040722193337.GE19329@fs.tum.de>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@fs.tum.de> wrote:
>
> my personal opinon is that this new development model isn't a good 
> idea from the point of view of users:
> 
> There's much worth in having a very stable kernel. Many people use for 
> different reasons self-compiled ftp.kernel.org kernels. 

Well.  We'll see.  2.6 is becoming stabler, despite the fact that we're
adding features.

I wouldn't be averse to releasing a 2.6.20.1 which is purely stability
fixes against 2.6.20 if there is demand for it.  Anyone who really cares
about stability of kernel.org kernels won't be deploying 2.6.20 within a
few weeks of its release anyway, so by the time they doodle over to
kernel.org they'll find 2.6.20.2 or whatever.
