Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965099AbWACXdM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965099AbWACXdM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 18:33:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965100AbWACXdJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 18:33:09 -0500
Received: from smtp.osdl.org ([65.172.181.4]:58036 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965108AbWACX3t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 18:29:49 -0500
Date: Tue, 3 Jan 2006 15:29:23 -0800
From: Andrew Morton <akpm@osdl.org>
To: Christoph Lameter <clameter@engr.sgi.com>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, ak@suse.de
Subject: Re: [PATCH] Fix the zone reclaim code in 2.6.15
Message-Id: <20060103152923.2f5bbfe9.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.62.0601031457300.22676@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.62.0601031457300.22676@schroedinger.engr.sgi.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter <clameter@engr.sgi.com> wrote:
>
> Some bits for zone reclaim exists in 2.6.15 but they are not usable.
>  This patch fixes them up, removes unused code and makes zone reclaim usable.
>

You know that there are over 100 mm/ patches in -mm.  If Linus applies this
patch, it will cause extensive wreckage.  And this patch doesn't vaguely
apply to the mm/ patches which I have queued.  So it's basically useless.

Please try to play along.

yes, it's awkward that there's such a large backlog in that area.  We just
need to be patient and extra careful.
