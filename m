Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261763AbTIYIK4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 04:10:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261764AbTIYIK4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 04:10:56 -0400
Received: from fw.osdl.org ([65.172.181.6]:31951 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261763AbTIYIKz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 04:10:55 -0400
Date: Thu, 25 Sep 2003 01:10:52 -0700
From: Andrew Morton <akpm@osdl.org>
To: Aaron Lehmann <aaronl@vitelus.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Complete I/O starvation with 3ware raid on 2.6
Message-Id: <20030925011052.6f8beab2.akpm@osdl.org>
In-Reply-To: <20030925075852.GI22525@vitelus.com>
References: <20030925071252.GE22525@vitelus.com>
	<20030925004301.171f6645.akpm@osdl.org>
	<20030925075852.GI22525@vitelus.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Aaron Lehmann <aaronl@vitelus.com> wrote:
>
> On Thu, Sep 25, 2003 at 12:43:01AM -0700, Andrew Morton wrote:
> > An update to the 3ware driver was merged yesterday.  Have you used earlier
> > 2.5 kernels?
> 
> More info: The load average is above ten just because of this copy,
> and even cating /proc/cpuinfo takes 10 seconds.

A few things to run are `top', `ps' and `vmstat 1'.

And `less Documentation/basic_profiling.txt' ;)


