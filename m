Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261379AbTIKQsn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 12:48:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261383AbTIKQsn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 12:48:43 -0400
Received: from ny03.mtek.chalmers.se ([129.16.60.203]:44305 "HELO
	ny03.mtek.chalmers.se") by vger.kernel.org with SMTP
	id S261379AbTIKQsm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 12:48:42 -0400
Subject: Re: Hard lock with recent 2.6.0-test kernels
From: Thomas Svedberg <thsv@am.chalmers.se>
To: Fedor Karpelevitch <fedor@karpelevitch.net>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <200309110725.53649.fedor@karpelevitch.net>
References: <1063272933.26472.16.camel@ampc545.am.chalmers.se>
	 <200309110725.53649.fedor@karpelevitch.net>
Content-Type: text/plain; charset=iso-8859-15
Message-Id: <1063298924.9623.22.camel@ampc545.am.chalmers.se>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Thu, 11 Sep 2003 18:48:45 +0200
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

tor 2003-09-11 klockan 16.25 skrev Fedor Karpelevitch:
> Thomas Svedberg wrote:
> > I first experienced total lockup with 2.6.0-test4-mm5 and have now
> > tried a few different ones. -test4-mm4 works, test4-bk2 works,
> > test4-mm5 locks, test4-bk3 locks, test5-mm1 locks.
> > Nothing shows in the logs, and the lock occurs while doing random
> > things but only after a few seconds - minutes after i logged in to
> > X. sysrq don't work either.
> > It is an Compaq Evo 1020v and configs etc. can be found at:
> > http://www.am.chalmers.se/~thsv/laptop/
> 
> looks to me like my favorite network-related lockup. do you ever get 
> it if you disconnect from network?

Just tried with -bk3 and it stayed stable (did make -j on a project of
mine that made load go to 40) until I connected the network cable and
restarted the network, and then it froze like before.

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



