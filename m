Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422833AbWHYEMG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422833AbWHYEMG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 00:12:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422835AbWHYEMG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 00:12:06 -0400
Received: from smtp.osdl.org ([65.172.181.4]:29675 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422833AbWHYEME (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 00:12:04 -0400
Date: Thu, 24 Aug 2006 21:05:31 -0700
From: Andrew Morton <akpm@osdl.org>
To: Josh Triplett <josht@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Pass sparse the lock expression given to lock
 annotations
Message-Id: <20060824210531.6264f285.akpm@osdl.org>
In-Reply-To: <1156466936.3418.58.camel@josh-work.beaverton.ibm.com>
References: <1156466936.3418.58.camel@josh-work.beaverton.ibm.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Aug 2006 17:48:56 -0700
Josh Triplett <josht@us.ibm.com> wrote:

> The lock annotation macros __acquires, __releases, __acquire, and __release
> all currently throw the lock expression passed as an argument.  Now that
> sparse can parse __context__ and __attribute__((context)) with a context
> expression, pass the lock expression down to sparse as the context expression.

What is the dependency relationship between your kernel changes and your
proposed change to sparse?

