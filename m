Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261427AbTIJKX7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 06:23:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261473AbTIJKX7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 06:23:59 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:50576 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S261427AbTIJKX6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 06:23:58 -0400
Date: Wed, 10 Sep 2003 11:23:46 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Ulrich Drepper <drepper@redhat.com>
Cc: linux-kernel@vger.kernel.org, "Hu, Boris" <boris.hu@intel.com>
Subject: Re: [PATCH] Split futex global spinlock futex_lock
Message-ID: <20030910102346.GB21313@mail.jlokier.co.uk>
References: <37FBBA5F3A361C41AB7CE44558C3448E01C0B69E@pdsmsx403.ccr.corp.intel.com> <3F5EF0B9.7020207@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F5EF0B9.7020207@redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ulrich Drepper wrote:
> Plus, currently we do not allocate locks so that the futexes fall in
> different buckets.  To some extend this is possible and would be a
> possible optimization if this patch goes in.

What do you mean?  The futexes should be in different buckets already
because of the hash function.

-- Jamie
