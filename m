Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263349AbTJQJM6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Oct 2003 05:12:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263351AbTJQJM6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Oct 2003 05:12:58 -0400
Received: from ny03.mtek.chalmers.se ([129.16.60.203]:18446 "HELO
	ny03.mtek.chalmers.se") by vger.kernel.org with SMTP
	id S263349AbTJQJM4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Oct 2003 05:12:56 -0400
Subject: Re: Hard lock with recent 2.6.0-test kernels
From: Thomas Svedberg <Thomas.Svedberg@me.chalmers.se>
To: Thomas Svedberg <thsv@am.chalmers.se>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>, jgarzik@pobox.com,
       netdev@oss.sgi.com
In-Reply-To: <1063272933.26472.16.camel@ampc545.am.chalmers.se>
References: <1063272933.26472.16.camel@ampc545.am.chalmers.se>
Content-Type: text/plain; charset=ISO-8859-1
Message-Id: <1066310622.1483.2.camel@thsvlap.swenox.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 17 Oct 2003 11:12:26 +0200
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have tried a lot more of the recent kernels, and still have these
lockups.
The box is, however, completely stable if i switch from running 8139cp
to 8139too.
I am willing to test patches.

tor 2003-09-11 klockan 11.35 skrev Thomas Svedberg:
> I first experienced total lockup with 2.6.0-test4-mm5 and have now tried
> a few different ones. -test4-mm4 works, test4-bk2 works, test4-mm5
> locks, test4-bk3 locks, test5-mm1 locks.
> Nothing shows in the logs, and the lock occurs while doing random things
> but only after a few seconds - minutes after i logged in to X.
> sysrq don't work either.
> It is an Compaq Evo 1020v and configs etc. can be found at:
> http://www.am.chalmers.se/~thsv/laptop/  
-- 
/ Thomas
.......................................................................
 Thomas Svedberg
 Department of Applied Mechanics 
 Chalmers University of Technology 

 Address: SE-412 96 Göteborg, SWEDEN 
 E-mail : thsv@am.chalmers.se, thsv@bigfoot.com
 Phone  : +46 31 772 1522
 Fax    : +46 31 772 3827
.......................................................................


