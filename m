Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261279AbUKHWbX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261279AbUKHWbX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 17:31:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261275AbUKHWat
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 17:30:49 -0500
Received: from fw.osdl.org ([65.172.181.6]:42131 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261273AbUKHWak (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 17:30:40 -0500
Date: Mon, 8 Nov 2004 14:34:09 -0800
From: Andrew Morton <akpm@osdl.org>
To: dhowells@redhat.com
Cc: torvalds@osdl.org, davidm@snapgear.com, linux-kernel@vger.kernel.org,
       uclinux-dev@uclinux.org
Subject: Re: [PATCH] Termio userspace access error handling
Message-Id: <20041108143409.79bf7fd8.akpm@osdl.org>
In-Reply-To: <200411081432.iA8EWewv023403@warthog.cambridge.redhat.com>
References: <200411081432.iA8EWewv023403@warthog.cambridge.redhat.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

dhowells@redhat.com wrote:
>
> The attached patch creates a generic set of termio userspace access functions
> with proper error handling. None of the current archs check for errors in this
> case.

Why are they inlined?
