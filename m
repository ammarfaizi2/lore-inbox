Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264255AbUFWVia@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264255AbUFWVia (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 17:38:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262085AbUFWVf5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 17:35:57 -0400
Received: from fw.osdl.org ([65.172.181.6]:11696 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266717AbUFWVa7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 17:30:59 -0400
Date: Wed, 23 Jun 2004 14:33:18 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jack Steiner <steiner@sgi.com>
Cc: davidm@hpl.hp.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] - Reduce TLB flushing during process migration
Message-Id: <20040623143318.07932255.akpm@osdl.org>
In-Reply-To: <20040623143844.GA15670@sgi.com>
References: <20040623143844.GA15670@sgi.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jack Steiner <steiner@sgi.com> wrote:
>
> This patch adds a platform specific hook to allow an arch-specific
> function to be called after an explicit migration.

OK by me.  David, could you please merge this up?

Jack, please prepare an update for Documentation/cachetlb.txt.
