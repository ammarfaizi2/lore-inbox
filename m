Return-Path: <linux-kernel-owner+w=401wt.eu-S1751278AbWLOIAk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751278AbWLOIAk (ORCPT <rfc822;w@1wt.eu>);
	Fri, 15 Dec 2006 03:00:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751269AbWLOIAj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Dec 2006 03:00:39 -0500
Received: from tur.go2.pl ([193.17.41.50]:59352 "EHLO tur.go2.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751278AbWLOIAj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Dec 2006 03:00:39 -0500
X-Greylist: delayed 1576 seconds by postgrey-1.27 at vger.kernel.org; Fri, 15 Dec 2006 03:00:39 EST
Date: Fri, 15 Dec 2006 08:35:14 +0100
From: Jarek Poplawski <jarkao2@o2.pl>
To: Alessandro Suardi <alessandro.suardi@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.19-git19: lockdep messages on console
Message-ID: <20061215073514.GA1594@ff.dom.local>
Mail-Followup-To: Jarek Poplawski <jarkao2@o2.pl>,
	Alessandro Suardi <alessandro.suardi@gmail.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a4c581d0612121149h4695dd51sd9cfbef8a3ef37f1@mail.gmail.com>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12-12-2006 20:49, Alessandro Suardi wrote:
> Very shortly after boot on my K7-800 running up-to-date FC6
> and 2.6.19-git19; didn't happen in 2.6.19-vanilla:
...
> [  134.915521] INFO: trying to register non-static key.
> [  134.915890] the code is fine but needs lockdep annotation.
> [  134.916249] turning off the locking correctness validator.

It looks like repaired in 2.6.20-rc1 by this:

[patch] lockdep: fix seqlock_init()

Regards,

Jarek P.
