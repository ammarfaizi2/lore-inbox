Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261177AbTIKJfg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 05:35:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261181AbTIKJff
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 05:35:35 -0400
Received: from ny03.mtek.chalmers.se ([129.16.60.203]:2058 "HELO
	ny03.mtek.chalmers.se") by vger.kernel.org with SMTP
	id S261177AbTIKJfc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 05:35:32 -0400
Subject: Hard lock with recent 2.6.0-test kernels
From: Thomas Svedberg <thsv@am.chalmers.se>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-15
Message-Id: <1063272933.26472.16.camel@ampc545.am.chalmers.se>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Thu, 11 Sep 2003 11:35:34 +0200
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I first experienced total lockup with 2.6.0-test4-mm5 and have now tried
a few different ones. -test4-mm4 works, test4-bk2 works, test4-mm5
locks, test4-bk3 locks, test5-mm1 locks.
Nothing shows in the logs, and the lock occurs while doing random things
but only after a few seconds - minutes after i logged in to X.
sysrq don't work either.
It is an Compaq Evo 1020v and configs etc. can be found at:
http://www.am.chalmers.se/~thsv/laptop/  
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



