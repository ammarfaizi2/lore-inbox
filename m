Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264454AbTFPXdM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 19:33:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264456AbTFPXdM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 19:33:12 -0400
Received: from netmagic.net ([206.14.125.10]:32428 "EHLO mail.netmagic.net")
	by vger.kernel.org with ESMTP id S264454AbTFPXdK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 19:33:10 -0400
Subject: Re: PROBLEM: 2.4.21 crashes hard running cdrecord in X.
From: Per Nystrom <pnystrom@netmagic.net>
To: Jan Knutar <jk-lkml@sci.fi>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200306161259.h5GCxBj04115@polaris.relay>
References: <1055722972.1502.39.camel@spike.sunnydale>
	 <1055728825.1482.8.camel@spike.sunnydale>
	 <1055731591.2028.4.camel@spike.sunnydale>
	 <200306161259.h5GCxBj04115@polaris.relay>
Content-Type: text/plain
Organization: 
Message-Id: <1055807219.1483.9.camel@spike.sunnydale>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 16 Jun 2003 16:46:59 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-06-16 at 05:56, Jan Knutar wrote:

> 
> Exactly the same experiences here, with 2 different motherboards and 2 
> different CD-RW drives, with various stock kernels since 2.4.9 or so. 
> Exactly the same resolution too, kill magicdev, and everything works 
> fine.
> 
> My machine would sometimes survive slightly longer, usually locking up 
> during fixating a disc. It would typically spit out massive amounts of 
> SCSI and IDE errors, while effectively locking up the machine for, what 
> at first was about 10 seconds at a time with a split second in an 
> unlocked state, but that would eventually worsen into a permanently 
> hard-locked state. 
> 
> Curiously enough, doing hdparm -y /dev/hdb (the cd burner), during one 
> of those split second unlocked states, would usually save the system. 
> It became standard practice for me to have an xterm su'd, in focus and 
> ready with "hdparm -y /dev/hdb" in it, while wiggling the mouse to see 
> when the pointer would freeze, to hit enter when/if it unfroze again 8-)

So counting myself, it sounds like there are at least 3 of us
experiencing a similar problem.  I didn't mention it in my original
post, but it's probably worth noting that I only started seeing this in
2.4.21.  I was running on 2.4.20 with the same setup for a long time,
and happily burning cds with magicdev running at the same time without
any trouble.


-- 
Per Nystrom <pnystrom@netmagic.net>

