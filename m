Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262001AbVANOnA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262001AbVANOnA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 09:43:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262002AbVANOnA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 09:43:00 -0500
Received: from mail.interware.hu ([195.70.32.130]:3025 "EHLO mail.interware.hu")
	by vger.kernel.org with ESMTP id S262001AbVANOmg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 09:42:36 -0500
Subject: sparc64 memory size anomaly
From: Hirling Endre <endre@interware.hu>
To: lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Fri, 14 Jan 2005 15:42:44 +0100
Message-Id: <1105713764.23663.69.camel@dusk.interware.hu>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I installed Linux (kernel 2.6.9/2.6.10, Debian Sid) on a Sun Fire v240
with 2 CPUs and 2G of RAM. If the memory modules are arranged according
to the manual (two modules for each cpu), Linux sees only 1.6G of the
memory. If I put all four memory modules beside one CPU, Linux sees all
two gigs. Under solaris there's no missing memory in either case.

Apart from this, Linux seems to work well on the machine.

Has anyone seen (or, more preferably, solved) this before?

greetings
endre

