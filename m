Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261454AbTDBDu3>; Tue, 1 Apr 2003 22:50:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261459AbTDBDu3>; Tue, 1 Apr 2003 22:50:29 -0500
Received: from locutus.cmf.nrl.navy.mil ([134.207.10.66]:20914 "EHLO
	locutus.cmf.nrl.navy.mil") by vger.kernel.org with ESMTP
	id <S261454AbTDBDu2>; Tue, 1 Apr 2003 22:50:28 -0500
Message-Id: <200304020400.h3240rGi004010@locutus.cmf.nrl.navy.mil>
To: Till Immanuel Patzschke <tip@inw.de>
cc: linux-atm-general@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [Linux-ATM-General] Re: [ATM] second pass at fixing atm spinlock 
In-reply-to: Your message of "Tue, 01 Apr 2003 16:45:05 PST."
             <3E8A3291.F8397F43@inw.de> 
X-url: http://www.nrl.navy.mil/CCS/people/chas/index.html
X-mailer: nmh 1.0
Date: Tue, 01 Apr 2003 23:00:53 -0500
From: chas williams <chas@locutus.cmf.nrl.navy.mil>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <3E8A3291.F8397F43@inw.de>,Till Immanuel Patzschke writes:
>I've merged your 2.4 patch w/ my changes and check w/ a couple of thousand PPPoA
>sessions created and destroyed over night (which always triggered the
>locking/unlocking vcc problems on my SMP box).

you might still see problem.  i didnt fix the race when opening to
prevent vpi/vci collisions.  however, i should have a patch tomorrow
to address this.
