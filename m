Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262725AbTCJFTT>; Mon, 10 Mar 2003 00:19:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262726AbTCJFTT>; Mon, 10 Mar 2003 00:19:19 -0500
Received: from pizda.ninka.net ([216.101.162.242]:39899 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S262725AbTCJFTS>;
	Mon, 10 Mar 2003 00:19:18 -0500
Date: Sun, 09 Mar 2003 21:11:08 -0800 (PST)
Message-Id: <20030309.211108.19997606.davem@redhat.com>
To: chas@locutus.cmf.nrl.navy.mil
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][ATM] obselete some atm_vcc members 
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200303100050.h2A0o5Gi003687@locutus.cmf.nrl.navy.mil>
References: <20030309.133453.05058422.davem@redhat.com>
	<200303100050.h2A0o5Gi003687@locutus.cmf.nrl.navy.mil>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: chas williams <chas@locutus.cmf.nrl.navy.mil>
   Date: Sun, 09 Mar 2003 19:50:05 -0500
   
   the spinlock isnt new.  the atm code has always had a global spinlock.
   i submitted a patch a couple weeks ago to convert the spinlock to a
   semaphore (so things would atleast work for now while i decide how to fix
   it the right way).  so my confusion is 'new spinlock'.  what new spinlock?
   did i miss something?

The important bit is that the patches you sent me didn't
apply, the rejects were in the sections that had references
to the older style atm device locking.

Whether the older style was one thing or another is irelevant.

The main point is that you need to send me clean patches
that actually apply to current 2.5.x trees :-)
