Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268985AbUI2UZ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268985AbUI2UZ4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 16:25:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268998AbUI2UZ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 16:25:56 -0400
Received: from smtp-103-wednesday.noc.nerim.net ([62.4.17.103]:8460 "EHLO
	mallaury.noc.nerim.net") by vger.kernel.org with ESMTP
	id S268985AbUI2UZx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 16:25:53 -0400
Date: Wed, 29 Sep 2004 22:26:19 +0200
From: Jean Delvare <khali@linux-fr.org>
To: LKML <linux-kernel@vger.kernel.org>
Subject: Re: mmap() on cdrom files fails since 2.6.9-rc2-bk2 (Was: in -mmX)
Message-Id: <20040929222619.5da3f207.khali@linux-fr.org>
In-Reply-To: <2Jw9b-52b-13@gated-at.bofh.it>
References: <2Jw9b-52b-13@gated-at.bofh.it>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting myself:

> I think I found a bug in 2.6.9-rc2-mm4. It doesn't seem to be able to
> mmap() files located on cdroms. Same problem with -mm3 and -mm1.
> 2.6.9-rc2 works fine. I reproduced it on two completely different
> systems, so I guess it isn't device dependant.

Looks like I should have done more testing before reporting. The problem
is not only in -mmX, it shows in the -bk series as well. The mmap()
problem I am experiencing seems to have been introduced between
2.6.9-rc2-bk1 and 2.6.9-rc2-bk2. This somewhat narrows the research
field.

I still don't know how to investigate the problem any further.
Suggestions welcome.

Thanks.

-- 
Jean Delvare
http://khali.linux-fr.org/
