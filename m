Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261927AbVGEV0n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261927AbVGEV0n (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 17:26:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261956AbVGEV0m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 17:26:42 -0400
Received: from smtp.osdl.org ([65.172.181.4]:19882 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261927AbVGEVNd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 17:13:33 -0400
Date: Tue, 5 Jul 2005 14:12:34 -0700
From: Andrew Morton <akpm@osdl.org>
To: Bongani Hlope <bonganilinux@mweb.co.za>
Cc: rudsve@drewag.de, linux-kernel@vger.kernel.org, torvalds@osdl.org,
       arjan@infradead.org, mingo@elte.hu, Little.Boss@physics.mcgill.ca
Subject: Re: Tracking a bug in x86-64
Message-Id: <20050705141234.3cab3328.akpm@osdl.org>
In-Reply-To: <200507052152.24022.bonganilinux@mweb.co.za>
References: <200506132259.22151.bonganilinux@mweb.co.za>
	<200506160139.04389.bonganilinux@mweb.co.za>
	<xfkll4lfy41.fsf@uxkm53.drewag.de>
	<200507052152.24022.bonganilinux@mweb.co.za>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bongani Hlope <bonganilinux@mweb.co.za> wrote:
>
> I haven't tested 2.6.12.2 but the problem was introduced around 2.6.11-mm1 and
>  found its way to 2.6.12-rcX. First try to run the following command (this works for me)
>  echo 0 > /proc/sys/kernel/randomize_va_space
>  I got an email from Juan Gallego (cc'd), he says that command does not work for him though.
> 
>  Andrew,
>  Should I log this on the kernel's bugzilla?

Yes please.  This is a tough one, and having one place to go to for the
info would be useful.
