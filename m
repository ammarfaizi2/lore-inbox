Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261814AbVAEDqB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261814AbVAEDqB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 22:46:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262231AbVAEDqB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 22:46:01 -0500
Received: from fw.osdl.org ([65.172.181.6]:42909 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261814AbVAEDp5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 22:45:57 -0500
Date: Tue, 4 Jan 2005 19:45:52 -0800
From: Chris Wright <chrisw@osdl.org>
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: Chris Wright <chrisw@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, "Jack O'Quin" <joq@io.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Christoph Hellwig <hch@infradead.org>,
       Lee Revell <rlrevell@joe-job.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
Message-ID: <20050104194552.Q2357@build.pdx.osdl.net>
References: <20050103140359.GA19976@infradead.org> <1104862614.8255.1.camel@krustophenia.net> <20050104182010.GA15254@infradead.org> <87u0pxhvn0.fsf@sulphur.joq.us> <1104865198.8346.8.camel@krustophenia.net> <1104878646.17166.63.camel@localhost.localdomain> <20050104175043.H469@build.pdx.osdl.net> <1104890131.18410.32.camel@krustophenia.net> <20050104180541.P2357@build.pdx.osdl.net> <A34D1E8C-5EC5-11D9-B35E-000393ACC76E@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <A34D1E8C-5EC5-11D9-B35E-000393ACC76E@mac.com>; from mrmacman_g4@mac.com on Tue, Jan 04, 2005 at 09:58:12PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Kyle Moffett (mrmacman_g4@mac.com) wrote:
> Here's a relatively simple idea: Why not make the "Realtime LSM"
> just check for a certain "Realtime" credential in the new credential
> store (Patch is in 2.6.10, see [1] for control program).  You would
> mark it as a system credential and give access to that credential via
> the appropriate capability with a small utility program.

Well, that's basically what the gid is in this case.  It's the credential
that's set at login time and has all the proper sharing and inheritance
rules.  So, I'm not yet convinced that this would buy us much.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
