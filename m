Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262872AbTE2U7c (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 16:59:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262903AbTE2U7M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 16:59:12 -0400
Received: from ns.suse.de ([213.95.15.193]:25614 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262872AbTE2U57 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 16:57:59 -0400
To: Mark Peloquin <peloquin@austin.ibm.com>
Cc: linux-kernel@vger.kernel.org, davem@redhat.com
Subject: Re: Nightly regression runs against current bk tree
References: <3ED66C83.8070608@austin.ibm.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 29 May 2003 23:11:17 +0200
In-Reply-To: <3ED66C83.8070608@austin.ibm.com.suse.lists.linux.kernel>
Message-ID: <p73smqx791m.fsf@oldwotan.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Peloquin <peloquin@austin.ibm.com> writes:

> We have dedicated a machine and thrown together some scripts that will grab
> and build the latest kernel files, execute the regression suite,
> collecting (hopefully)
> enough system state information to allow meaningful analysis of any peculiar
> results encountered.

How about doing a LTP run too with some difference file for new FAILs/BROKs ?
That's not strictly a benchmark, but would help catching regressions
quickly.

I notice your benchmark mix is very IO heavy, it would be nice to test other
aspects of the system too. Perhaps lmbench and reaim compute workload?

It would be nice if we had a new linux-testresults list where such
updates could be posted regularly. I don't think it belong on l-k
because it would be too noisy. Perhaps such a list could be added to 
vger. David, what do you think?

-Andi
