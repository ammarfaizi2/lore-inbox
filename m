Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261843AbULaJv5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261843AbULaJv5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Dec 2004 04:51:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261847AbULaJv4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Dec 2004 04:51:56 -0500
Received: from [202.141.25.89] ([202.141.25.89]:33004 "EHLO
	pridns.cs.iitm.ernet.in") by vger.kernel.org with ESMTP
	id S261843AbULaJvo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Dec 2004 04:51:44 -0500
Subject: Re: swsusp: Kill O(n^2) algorithm in swsusp
References: <20041225175453.GA10222@elf.ucw.cz>
From: Rajsekar <raj--cutme--sekar@cse.iDELTHISitm.ernet.in>
To: linux-kernel@vger.kernel.org
Date: Fri, 31 Dec 2004 15:17:38 +0530
In-Reply-To: <20041225175453.GA10222@elf.ucw.cz> (Pavel Machek's message of
 "Sat, 25 Dec 2004 18:54:54 +0100")
Message-ID: <m31xd6yf2d.fsf@rajsekar.pc>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The patch is really too good.
My comp now suspends in around 5seconds.  Before patching, it took around a
minute (sometimes more).  Hats off to you.

Details (if you care)

#uname -a
Linux rajsekar.pc 2.6.10-rc1-ck1-reiser4 #3 Fri Dec 31 07:47:32 IST 2004 i686 AuthenticAMD unknown GNU/Linux

Tell me if you want me to test anything else.

-- 
    Rajsekar

