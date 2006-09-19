Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751363AbWISWfI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751363AbWISWfI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 18:35:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751367AbWISWfH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 18:35:07 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:32970 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751345AbWISWfF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 18:35:05 -0400
Date: Tue, 19 Sep 2006 21:02:14 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: Kylene Jo Hall <kjhall@us.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       LSM ML <linux-security-module@vger.kernel.org>,
       Dave Safford <safford@us.ibm.com>, Mimi Zohar <zohar@us.ibm.com>,
       Serge Hallyn <sergeh@us.ibm.com>
Subject: Re: [PATCH 0/7] Integrity Service and SLIM
Message-ID: <20060919190214.GA7210@elf.ucw.cz>
References: <1158083845.18137.10.camel@localhost.localdomain> <20060914165113.3067c4b0.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060914165113.3067c4b0.akpm@osdl.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2006-09-14 16:51:13, Andrew Morton wrote:
> On Tue, 12 Sep 2006 10:57:25 -0700
> Kylene Jo Hall <kjhall@us.ibm.com> wrote:
> 
> > This is an updated request for comments on a proposed integrity 
> > service framework and dummy provider, along with SLIM, a low 
> > water-mark mandatory access control LSM module which utilizes the 
> > integrity services as additional input to the access control decisions.
> 
> Having carefully reviewed your code I have come to the firm conclusion that
> it is written in C.  The next step is to put it all in -mm and see if
> anyone shouts at me.

Hmmm, "it is written in C" does not seem like good enough reason to
merge it... right?

I tried to understand what it is good for, but it seems that in
current state it is not much good for anything.

Will IBM work at splitting ssh so that trusted/untrusted portions are
separated?

								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
