Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932672AbWAGG3Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932672AbWAGG3Q (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 01:29:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932679AbWAGG3Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 01:29:16 -0500
Received: from smtp.osdl.org ([65.172.181.4]:52908 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932672AbWAGG3P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 01:29:15 -0500
Date: Fri, 6 Jan 2006 22:28:51 -0800
From: Andrew Morton <akpm@osdl.org>
To: Arjan van de Ven <arjan@infradead.org>
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu
Subject: Re: [patch 6/7] Unlinline a bunch of other functions
Message-Id: <20060106222851.713e0289.akpm@osdl.org>
In-Reply-To: <1136544226.2940.23.camel@laptopd505.fenrus.org>
References: <1136543825.2940.8.camel@laptopd505.fenrus.org>
	<1136544226.2940.23.camel@laptopd505.fenrus.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven <arjan@infradead.org> wrote:
>
>  Remove the "inline" keyword from a bunch of big functions in the kernel
>  with the goal of shrinking it by 30kb to 40kb

Was this done very carefully?  I look at e100_start_receiver() and cannot
see a reason for uninlining it.  Are there others?
