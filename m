Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S273184AbTHKSzy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 14:55:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S273111AbTHKSyj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 14:54:39 -0400
Received: from fw.osdl.org ([65.172.181.6]:50573 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S272988AbTHKSxV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 14:53:21 -0400
Date: Mon, 11 Aug 2003 11:39:43 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.6.0-test3-mm1
Message-Id: <20030811113943.47e5fd85.akpm@osdl.org>
In-Reply-To: <94490000.1060612530@[10.10.2.4]>
References: <20030809203943.3b925a0e.akpm@osdl.org>
	<94490000.1060612530@[10.10.2.4]>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin J. Bligh" <mbligh@aracnet.com> wrote:
>
> Degredation on kernbench is still there:
> 
> Kernbench: (make -j N vmlinux, where N = 16 x num_cpus)
>                               Elapsed      System        User         CPU
>               2.6.0-test3       45.97      115.83      571.93     1494.50
>           2.6.0-test3-mm1       46.43      122.78      571.87     1496.00
> 
> Quite a bit of extra sys time.

Increased system is a surprise.  Profiles would be interesting, thanks.

