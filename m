Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129626AbQLAWy7>; Fri, 1 Dec 2000 17:54:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129771AbQLAWyt>; Fri, 1 Dec 2000 17:54:49 -0500
Received: from atlrel2.hp.com ([156.153.255.202]:37877 "HELO atlrel2.hp.com")
	by vger.kernel.org with SMTP id <S129626AbQLAWyo>;
	Fri, 1 Dec 2000 17:54:44 -0500
From: Scott Rhine <rhine@rsn.hp.com>
Message-Id: <200012012223.QAA07257@hueco-e.rsn.hp.com>
Subject: December updates to plug in scheduler policies
To: rhine@hueco-e.rsn.hp.com
Date: Fri, 01 Dec 2000 16:23:58 CST
Cc: linux-kernel@vger.kernel.org, linux-announce@sws1.ctd.ornl.gov
X-Mailer: Elm [revision: 111.1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://resourcemanagement.unixsolutions.hp.com/WaRM/schedpolicy.html

Changes included: 

   1.a new benchmark for realtime testing called sched_rr 
   2.a fix to YIELD code in pset.c which could result in a hang after 
	cpu assign of a busy cpu on Linux 2.2.16. 
   3.the release of a multi run queue prototype. 

Note that the multi run queue patch is for sched.c only. It will be integrated 
with loadable modules and psets as soon as we have final 2_4 bits. Performance
numbers for the multi queue scheduler are provided in a separate white paper. 

Watch for our demonstration at the HP booth in the upcoming Linux World! 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
