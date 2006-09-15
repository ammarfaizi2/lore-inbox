Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932066AbWIORJD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932066AbWIORJD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 13:09:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932067AbWIORJD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 13:09:03 -0400
Received: from mtagate1.uk.ibm.com ([195.212.29.134]:13891 "EHLO
	mtagate1.uk.ibm.com") by vger.kernel.org with ESMTP id S932066AbWIORJA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 13:09:00 -0400
Subject: Re: [patch] Race condition in usermodehelper.
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
To: Andrew Morton <akpm@osdl.org>
Cc: torvalds@osdl.org, gregkh@suse.de, bunk@stusta.de,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060915092600.3046c511.akpm@osdl.org>
References: <20060915104654.GA31548@skybase>
	 <20060915092600.3046c511.akpm@osdl.org>
Content-Type: text/plain
Organization: IBM Corporation
Date: Fri, 15 Sep 2006 19:08:56 +0200
Message-Id: <1158340136.23993.25.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-09-15 at 09:26 -0700, Andrew Morton wrote:
> > [patch] Race condition in usermodehelper.
>
> You mean three days work?

Unfortunately yes. You really have to hit the machine hard to provoke
this oops. All I had to work with was a dump that showed me the content
of the memory after it crashed.

> If so, I owe you a big apology, because an identical patch has been in -mm
> for over a month.  I guess I didn't appreciate its significance.

Well, I could have looked in -mm after the first suspicion that there is
something wrong with the kernel module loader. It would have saved me 2
of the 3 days.. will remember for the next debug session.

> Shall expedite.

Please do.

-- 
blue skies,
  Martin.

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH

"Reality continues to ruin my life." - Calvin.


