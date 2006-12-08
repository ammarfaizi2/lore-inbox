Return-Path: <linux-kernel-owner+w=401wt.eu-S1425573AbWLHPry@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1425573AbWLHPry (ORCPT <rfc822;w@1wt.eu>);
	Fri, 8 Dec 2006 10:47:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1425579AbWLHPry
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 10:47:54 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:60920 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1425573AbWLHPry (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 10:47:54 -0500
Date: Fri, 8 Dec 2006 15:55:37 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: Al Boldi <a1426z@gawab.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: additional oom-killer tuneable worth submitting?
Message-ID: <20061208155537.6f19b7e9@localhost.localdomain>
In-Reply-To: <200612081819.43991.a1426z@gawab.com>
References: <200612081658.29338.a1426z@gawab.com>
	<20061208145605.1a8b0815@localhost.localdomain>
	<200612081819.43991.a1426z@gawab.com>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> What I understood from Arjan is that the problem isn't swapspace, but rather 
> that shared-libs are implement via a COW trick, which always overcommits, no 
> matter what.

The zero overcommit layer accounts address space not pages.

> Are you saying there is some new no-overcommit functionality in 2.6.19, or 
> has this been there before?

Red Hat Enterprise Linux for a very long time, got merged upstream a long
long time ago to. Then got various fixes along the way. It's old
functionality.

Alan
