Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261163AbTINNjb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Sep 2003 09:39:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261169AbTINNjb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Sep 2003 09:39:31 -0400
Received: from math.ut.ee ([193.40.5.125]:37083 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S261163AbTINNj0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Sep 2003 09:39:26 -0400
Date: Sun, 14 Sep 2003 14:11:45 +0300 (EEST)
From: Meelis Roos <mroos@linux.ee>
To: linux-kernel@vger.kernel.org
Subject: qla1280 & __flush_cache_all
In-Reply-To: <20030911075609.053a54ed.davem@redhat.com>
Message-ID: <Pine.GSO.4.44.0309141410080.27187-100000@math.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Sep 2003, David S. Miller wrote:

> Meelis Roos <mroos@linux.ee> wrote:
> >
> > Is __flush_cache_all an universal thing or just platform-specific?
> > qla1280 seems to have started using it and it does not link on sparc64.
> >
> > *** Warning: "__flush_cache_all" [drivers/scsi/qla1280.ko] undefined!
>
> There is no reason a scsi driver should be invoking that interface.

So why is qla1280 in 2.6-current using __flush_cache_all?

-- 
Meelis Roos (mroos@linux.ee)

