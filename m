Return-Path: <linux-kernel-owner+w=401wt.eu-S964920AbXASWBO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964920AbXASWBO (ORCPT <rfc822;w@1wt.eu>);
	Fri, 19 Jan 2007 17:01:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964932AbXASWBO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Jan 2007 17:01:14 -0500
Received: from ns1.suse.de ([195.135.220.2]:54133 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964920AbXASWBN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Jan 2007 17:01:13 -0500
From: Andi Kleen <ak@suse.de>
To: Hugh Dickins <hugh@veritas.com>
Subject: Re: unable to mmap /dev/kmem
Date: Sat, 20 Jan 2007 08:57:55 +1100
User-Agent: KMail/1.9.1
Cc: Nadia Derbey <Nadia.Derbey@bull.net>, Franck Bui-Huu <fbuihuu@gmail.com>,
       LKML <linux-kernel@vger.kernel.org>
References: <45AFA490.5000508@bull.net> <45B08B17.3060807@bull.net> <Pine.LNX.4.64.0701191539070.4009@blonde.wat.veritas.com>
In-Reply-To: <Pine.LNX.4.64.0701191539070.4009@blonde.wat.veritas.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701200857.55407.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> But personally I'd prefer it to remain.

Similar. I also got some tools who use it to read kernel variables
and doing the V->P conversion in user space would be tedious
and unreliable (e.g. for vmalloc) 

-Andi
