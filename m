Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261278AbUKHWnD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261278AbUKHWnD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 17:43:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261286AbUKHWnC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 17:43:02 -0500
Received: from fw.osdl.org ([65.172.181.6]:60827 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261278AbUKHWks (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 17:40:48 -0500
Date: Mon, 8 Nov 2004 14:44:33 -0800
From: Andrew Morton <akpm@osdl.org>
To: dhowells@redhat.com
Cc: torvalds@osdl.org, davidm@snapgear.com, linux-kernel@vger.kernel.org,
       uclinux-dev@uclinux.org
Subject: Re: [PATCH] Additional kgdb hooks
Message-Id: <20041108144433.079f0f7c.akpm@osdl.org>
In-Reply-To: <200411081432.iA8EWf0c023426@warthog.cambridge.redhat.com>
References: <200411081432.iA8EWf0c023426@warthog.cambridge.redhat.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

dhowells@redhat.com wrote:
>
> The attached patch adds a couple of extra hooks by which kgdb or an equivalent
> gdbstub can catch bad_page() and panic() invocations.

Tom is valiantly flogging his way through a generic KGDB implementation.  I
think it would be better to push ahead with that and to not put into
generic code hooks which are specific to one arch's kgdb implementation.

