Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750749AbWHYKNe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750749AbWHYKNe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 06:13:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750913AbWHYKNe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 06:13:34 -0400
Received: from mtagate1.uk.ibm.com ([195.212.29.134]:29604 "EHLO
	mtagate1.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1750749AbWHYKNe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 06:13:34 -0400
Subject: Re: [PATCH 1/3] kthread: update s390 cmm driver to use kthread
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1156496014.1640.9.camel@localhost>
References: <20060824212241.GB30007@sergelap.austin.ibm.com>
	 <1156496014.1640.9.camel@localhost>
Content-Type: text/plain
Organization: IBM Corporation
Date: Fri, 25 Aug 2006 12:13:31 +0200
Message-Id: <1156500811.1640.12.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-08-25 at 10:53 +0200, Martin Schwidefsky wrote:
> > This patch compiles and boots fine, but I don't know how to really
> > test the driver.
> 
> Just tried the patch and tested cmm. Still works fine. Patch added to my
> "things-that-will-go-out-after-2.6.18" list of patches.

Heiko just pointed out that this has already been fixed. His patch
depends on another patch (oom-killer) and can be found in the current
-mm tree. I'll drop this patch.

-- 
blue skies,
  Martin.

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH

"Reality continues to ruin my life." - Calvin.


