Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262685AbTCJAjw>; Sun, 9 Mar 2003 19:39:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262686AbTCJAjw>; Sun, 9 Mar 2003 19:39:52 -0500
Received: from locutus.cmf.nrl.navy.mil ([134.207.10.66]:26777 "EHLO
	locutus.cmf.nrl.navy.mil") by vger.kernel.org with ESMTP
	id <S262685AbTCJAjv>; Sun, 9 Mar 2003 19:39:51 -0500
Message-Id: <200303100050.h2A0o5Gi003687@locutus.cmf.nrl.navy.mil>
To: "David S. Miller" <davem@redhat.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][ATM] obselete some atm_vcc members 
In-reply-to: Your message of "Sun, 09 Mar 2003 13:34:53 PST."
             <20030309.133453.05058422.davem@redhat.com> 
X-url: http://www.nrl.navy.mil/CCS/people/chas/index.html
X-mailer: nmh 1.0
Date: Sun, 09 Mar 2003 19:50:05 -0500
From: chas williams <chas@locutus.cmf.nrl.navy.mil>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030309.133453.05058422.davem@redhat.com>,"David S. Miller" writes:
>This stuff was all against a tree which still had the atm_dev
>semaphore instead of the new spinlock.  Therefore half of the patches
>rejected and I had to put these parts in by hand.

the spinlock isnt new.  the atm code has always had a global spinlock.
i submitted a patch a couple weeks ago to convert the spinlock to a
semaphore (so things would atleast work for now while i decide how to fix
it the right way).  so my confusion is 'new spinlock'.  what new spinlock?
did i miss something?
