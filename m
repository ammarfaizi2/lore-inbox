Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261577AbVCRLX1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261577AbVCRLX1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 06:23:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261581AbVCRLX1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 06:23:27 -0500
Received: from fire.osdl.org ([65.172.181.4]:14776 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261577AbVCRLXY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 06:23:24 -0500
Date: Fri, 18 Mar 2005 03:22:55 -0800
From: Andrew Morton <akpm@osdl.org>
To: Martin Waitz <tali@admingilde.org>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docbook: fix escaping of kernel-doc
Message-Id: <20050318032255.6423144e.akpm@osdl.org>
In-Reply-To: <20050318111658.GM8617@admingilde.org>
References: <200503112034.j2BKYMli008385@shell0.pdx.osdl.net>
	<20050314081319.GD8617@admingilde.org>
	<20050314004712.4746f2cf.akpm@osdl.org>
	<20050318111658.GM8617@admingilde.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Waitz <tali@admingilde.org> wrote:
>
>  ... and I really have to redo my bitkeeper repository as it
>  is full of merge artifacts as BK did not note the fact that
>  the patches were applied using normal patches.

Normally bk would handle that, but I have an irritating habit of stripping
off all the trailing whitespace which people keep trying to add to the
kernel.

>  I guess I have to use one complete tree per patch and recreate
>  the public repo as a combination of the individual ones.
>  Alternatives?

Export all the csets as unified diffs, reapply them.
