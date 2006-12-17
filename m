Return-Path: <linux-kernel-owner+w=401wt.eu-S1752434AbWLQLGR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752434AbWLQLGR (ORCPT <rfc822;w@1wt.eu>);
	Sun, 17 Dec 2006 06:06:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752433AbWLQLGR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Dec 2006 06:06:17 -0500
Received: from smtp.osdl.org ([65.172.181.25]:55740 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752431AbWLQLGQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Dec 2006 06:06:16 -0500
Date: Sun, 17 Dec 2006 03:05:39 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Jeff Garzik <jeff@garzik.org>, Neil Brown <neilb@suse.de>,
       Jurriaan <thunder7@xs4all.nl>, linux-kernel@vger.kernel.org,
       linux-raid@vger.kernel.org, Tejun Heo <htejun@gmail.com>,
       Alan <alan@lxorguk.ukuu.org.uk>, Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: sata badness in 2.6.20-rc1? [Was: Re: md patches in -mm]
Message-Id: <20061217030539.a7ac1a68.akpm@osdl.org>
In-Reply-To: <200612171200.13075.rjw@sisk.pl>
References: <20061204203410.6152efec.akpm@osdl.org>
	<200612161056.26830.rjw@sisk.pl>
	<200612161216.07669.rjw@sisk.pl>
	<200612171200.13075.rjw@sisk.pl>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 17 Dec 2006 12:00:12 +0100
"Rafael J. Wysocki" <rjw@sisk.pl> wrote:

> Okay, I have identified the patch that causes the problem to appear, which is
> 
> fix-sense-key-medium-error-processing-and-retry.patch
> 
> With this patch reverted -rc1-mm1 is happily running on my test box.

That was rather unexpected.   Thanks.
