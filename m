Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261916AbVDVBss@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261916AbVDVBss (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 21:48:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261914AbVDVBss
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 21:48:48 -0400
Received: from fmr17.intel.com ([134.134.136.16]:30377 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S261878AbVDVBsp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 21:48:45 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17000.22515.170455.192374@sodium.jf.intel.com>
Date: Thu, 21 Apr 2005 18:48:35 -0700
To: Petr Baudis <pasky@ucw.cz>
Cc: tony.luck@intel.com, Linus Torvalds <torvalds@osdl.org>,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: ia64 git pull
In-Reply-To: <20050422012546.GD1474@pasky.ji.cz>
References: <200504212042.j3LKgng04318@unix-os.sc.intel.com>
	<Pine.LNX.4.58.0504211403080.2344@ppc970.osdl.org>
	<200504212155.j3LLtho04949@unix-os.sc.intel.com>
	<200504212301.j3LN1Do05507@unix-os.sc.intel.com>
	<20050422012546.GD1474@pasky.ji.cz>
X-Mailer: VM 7.19 under Emacs 21.3.1
From: Inaky Perez-Gonzalez <inaky@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> Petr Baudis <pasky@ucw.cz> writes:

> I've just added to git-pasky a possibility to refer to branches
> inside of repositories by a fragment identifier:

> rsync://rsync.kernel.org/pub/scm/linux/kernel/git/aegl/linux-2.6.git#testing

> will refer to your testing branch in that repository.

Can we use something other than #? we'll have to scape it all the time
in the shell (or at least also allow some other char, something
without special meta-character meaning in the shell, like %).

-- 

Inaky

