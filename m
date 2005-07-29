Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262775AbVG2UC0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262775AbVG2UC0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 16:02:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262783AbVG2UCW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 16:02:22 -0400
Received: from smtp.osdl.org ([65.172.181.4]:20660 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262786AbVG2UAo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 16:00:44 -0400
Date: Fri, 29 Jul 2005 12:59:28 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Salyzyn, Mark" <mark_salyzyn@adaptec.com>
Cc: drab@kepler.fjfi.cvut.cz, linux-kernel@vger.kernel.org, markh@osdl.org
Subject: Re: AACRAID failure with 2.6.13-rc1
Message-Id: <20050729125928.18d41cf7.akpm@osdl.org>
In-Reply-To: <60807403EABEB443939A5A7AA8A7458B017927DC@otce2k01.adaptec.com>
References: <60807403EABEB443939A5A7AA8A7458B017927DC@otce2k01.adaptec.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Salyzyn, Mark" <mark_salyzyn@adaptec.com> wrote:
>
> Martin may be overplaying the performance angle.
> 
> A previous patch took the adapter from 64K to 4MB transaction sizes
> across the board. This caused Martin's adapter and drive combination to
> tip-over. We had to scale back to 128KB sized transactions to get
> stability on his system. All systems handled the 4MB I/O size in our
> tests, but the tests that were done some time ago were not performed
> with the latest kernel, which contributed to a change in testing
> corners.

Confused.  The above appears to indicate that we should put the workaround
into 2.6.13, yes?

