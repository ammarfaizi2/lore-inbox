Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266782AbUG1FKW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266782AbUG1FKW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 01:10:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266784AbUG1FKW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 01:10:22 -0400
Received: from fw.osdl.org ([65.172.181.6]:37011 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266782AbUG1FKT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 01:10:19 -0400
Date: Tue, 27 Jul 2004 22:08:52 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: writepages drops bh on not uptodate page
Message-Id: <20040727220852.75330a53.akpm@osdl.org>
In-Reply-To: <20040728045156.GH15895@dualathlon.random>
References: <20040728045156.GH15895@dualathlon.random>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli <andrea@suse.de> wrote:
>
> the below fix
>  just explains everything we've seen since not-fully-uptodate pages must
>  have always bh on them and the below patch enforces just that invariant,
>  and it should fix our pagecache-overwritten-by-disk-data problem.

Yes, I agree.   Thanks again for that.
