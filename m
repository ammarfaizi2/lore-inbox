Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278464AbRJZOPA>; Fri, 26 Oct 2001 10:15:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278490AbRJZOOu>; Fri, 26 Oct 2001 10:14:50 -0400
Received: from relay02.cablecom.net ([62.2.33.102]:63238 "EHLO
	relay02.cablecom.net") by vger.kernel.org with ESMTP
	id <S278464AbRJZOOj>; Fri, 26 Oct 2001 10:14:39 -0400
Message-Id: <200110261415.f9QEF9305606@mail.swissonline.ch>
Content-Type: text/plain; charset=US-ASCII
From: Christian Widmer <cwidmer@iiic.ethz.ch>
Reply-To: cwidmer@iiic.ethz.ch
To: <linux-kernel@vger.kernel.org>
Subject: priority queues on dp83820
Date: Fri, 26 Oct 2001 16:01:48 +0200
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

has anybody try to use the priority queues of the dp83820?
or does somebody know where to get docu knewer then the 
preliminary form february 2001?

i wrote a driver for the dp83820. now i tried to use 
priority queuing for prescheduled zero copy datastreans.
first i just whanted enable priority queueing without 
inserting of any vlan tag. this works for 1 to 3 queues 
like it sais in the docu (untagged packets are queued 
like packets with priority 0). but when i enable the 4th
queue i receive all none tagged data on queue 1 instead 
of queue 0. and if i enalbe vlan-tagging globaly or on 
a per packet basis i don't get any interrupts on the 
receiving side. has anybody an idea whats going on. if 
you need the code to have a lock at - let me know, i 
realy need some help.

chris

