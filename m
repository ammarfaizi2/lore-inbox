Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262497AbUCRKLC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 05:11:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262503AbUCRKLB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 05:11:01 -0500
Received: from fw.osdl.org ([65.172.181.6]:17076 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262497AbUCRKK6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 05:10:58 -0500
Date: Thu, 18 Mar 2004 02:10:57 -0800
From: Andrew Morton <akpm@osdl.org>
To: drepper@redhat.com, linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: sched_setaffinity usability
Message-Id: <20040318021057.287f4f67.akpm@osdl.org>
In-Reply-To: <20040318014517.3cd232c4.akpm@osdl.org>
References: <40595842.5070708@redhat.com>
	<20040318014517.3cd232c4.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:
>
> +		if (find_next_bit(&u, nr_bits, 0) >= nr_bits)

Make that:

> +		if (find_next_bit(&u, nr_bits, 0) < nr_bits)

