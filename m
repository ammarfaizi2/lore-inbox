Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750756AbWJPO6p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750756AbWJPO6p (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 10:58:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750760AbWJPO6p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 10:58:45 -0400
Received: from mtagate2.de.ibm.com ([195.212.29.151]:56980 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP
	id S1750756AbWJPO6n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 10:58:43 -0400
Date: Mon, 16 Oct 2006 16:59:15 +0200
From: Cornelia Huck <cornelia.huck@de.ibm.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Greg K-H <greg@kroah.com>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Patch 0/3] Driver core: Some probing changes
Message-ID: <20061016165915.774df040@gondolin.boeblingen.de.ibm.com>
In-Reply-To: <Pine.LNX.4.44L0.0610161036120.7103-100000@iolanthe.rowland.org>
References: <20061016104407.0fc87c4c@gondolin.boeblingen.de.ibm.com>
	<Pine.LNX.4.44L0.0610161036120.7103-100000@iolanthe.rowland.org>
X-Mailer: Sylpheed-Claws 2.5.5 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Oct 2006 10:39:28 -0400 (EDT),
Alan Stern <stern@rowland.harvard.edu> wrote:

> Patch 1 is somewhat questionable.  Certainly the log message reporting the
> error should be left in.

OK, that makes sense. I'll do an updated patch.

> The other issue is whether to continue with
> probing other drivers.  I guess there's no reason not to; stopping short
> was merely an optimization.

And not stopping also solves the "broken driver prevents any other
driver from matching" problem.

-- 
Cornelia Huck
Linux for zSeries Developer
Tel.: +49-7031-16-4837, Mail: cornelia.huck@de.ibm.com
