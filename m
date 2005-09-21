Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750835AbVIUSxi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750835AbVIUSxi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 14:53:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751001AbVIUSxi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 14:53:38 -0400
Received: from smtp.osdl.org ([65.172.181.4]:32159 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750835AbVIUSxh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 14:53:37 -0400
Date: Wed, 21 Sep 2005 11:52:56 -0700
From: Andrew Morton <akpm@osdl.org>
To: Hans Reiser <reiser@namesys.com>
Cc: linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
Subject: Re: latest patches degrade reiser4 performance substantially
Message-Id: <20050921115256.6a11ab8d.akpm@osdl.org>
In-Reply-To: <4331A9BD.5030006@namesys.com>
References: <4331A9BD.5030006@namesys.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hans Reiser <reiser@namesys.com> wrote:
>
> At the this time we have no idea which patch is responsible, probably in
> a day or two we'll have a patch to fix it.
> 

OK.  I assume this performance change is demonstrable in just
2.6.14-rc2+reiser4?  Beware that there are other changes in the -mm lineup
which might cause regressions.  Notably

	mm-try-to-allocate-higher-order-pages-in-rmqueue_bulk.patch

and

	per-task-predictive-write-throttling-1.patch
	per-task-predictive-write-throttling-1-tweaks.patch

