Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269293AbUIYJmR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269293AbUIYJmR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Sep 2004 05:42:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269294AbUIYJmR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Sep 2004 05:42:17 -0400
Received: from rproxy.gmail.com ([64.233.170.201]:42699 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S269293AbUIYJmQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Sep 2004 05:42:16 -0400
Message-ID: <35fb2e590409250242dd353d9@mail.gmail.com>
Date: Sat, 25 Sep 2004 10:42:15 +0100
From: Jon Masters <jonmasters@gmail.com>
Reply-To: jonathan@jonmasters.org
To: Russell King <rmk@arm.linux.org.uk>
Subject: Re: Add wait_event_timeout()
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
In-Reply-To: <20040925091359.GA4431@dyn-67.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20040925091359.GA4431@dyn-67.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Sep 2004 10:13:59 +0100, Russell King <rmk@arm.linux.org.uk> wrote:

> There appears to be one case missing from the wait_event() family -
> the uninterruptible timeout wait.  The following patch adds this.


Any reason it's called wait_event_timeout then rather than
wait_event_uninterruptible_timeout?

Jon.
