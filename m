Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262846AbUJ1JWA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262846AbUJ1JWA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 05:22:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262848AbUJ1JWA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 05:22:00 -0400
Received: from fw.osdl.org ([65.172.181.6]:57250 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262846AbUJ1JV4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 05:21:56 -0400
Date: Thu, 28 Oct 2004 02:19:54 -0700
From: Andrew Morton <akpm@osdl.org>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9 page allocation failures
Message-Id: <20041028021954.237010f8.akpm@osdl.org>
In-Reply-To: <1098888880.20643.130.camel@dyn318077bld.beaverton.ibm.com>
References: <1098888880.20643.130.camel@dyn318077bld.beaverton.ibm.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Badari Pulavarty <pbadari@us.ibm.com> wrote:
>
> Hi,
> 
> I see following page allocation failures while running IO intensive
> tests on 2.6.9. My tests didn't fail, so I guess its okay. But
> I never saw this before.
> 
> Its on a 4-way AMD64 machine with 7GB RAM. Tests create 10 4GB files
> on 10 disks (one filesystem per disk) in parallel. (dd if=/dev/zero ...)

Tried increasing /proc/sys/vm/min_free_kbytes?
