Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264401AbUFGKi5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264401AbUFGKi5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 06:38:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264402AbUFGKi5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 06:38:57 -0400
Received: from postoffice9.mail.cornell.edu ([132.236.56.39]:62926 "EHLO
	postoffice9.mail.cornell.edu") by vger.kernel.org with ESMTP
	id S264401AbUFGKi4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 06:38:56 -0400
Message-ID: <40C445D8.80804@cornell.edu>
Date: Mon, 07 Jun 2004 04:39:20 -0600
From: Ivan Gyurdiev <ivg2@cornell.edu>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040519)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nathan Scott <nathans@sgi.com>
CC: Linux-Kernel <linux-kernel@vger.kernel.org>, linux-xfs@oss.sgi.com
Subject: Re: xfs corruption or not
References: <40BFDB13.7000901@cornell.edu> <20040604052953.GE13756@frodo>
In-Reply-To: <20040604052953.GE13756@frodo>
X-Enigmail-Version: 0.84.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-PMX-Version: 4.5.0.90627, Antispam-Core: 4.0.4.92622, Antispam-Data: 2004.6.6.102728
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Do you know if the kernel was low on memory at the time?  (any
> signs of allocation failures in your system log?)
> 
> This looks like a memory allocation failure which hasn't been
> gracefully handled (or approriately retried) in XFS - there's
> a few patches being worked on to improve this, but they aren't
> ready to be merged in just yet.


---
Well, now that you mention it, there's another trace right in front of
the oops. Don't know why I missed it - probably thought it was the same
thing. It says allocation failure. I am running FC2 with 128MB SDRAM.
----

(Trace in previous message in thread)

I think this is caused by working with a 385 MB LKML archive file when 
low on memory (basically all the time..) I can't ls -l that particular 
folder after t-bird locks up, since ls locks up too and becomes unkillable.








