Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266930AbSKLUlE>; Tue, 12 Nov 2002 15:41:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266931AbSKLUlE>; Tue, 12 Nov 2002 15:41:04 -0500
Received: from kim.it.uu.se ([130.238.12.178]:25298 "EHLO kim.it.uu.se")
	by vger.kernel.org with ESMTP id <S266930AbSKLUlD>;
	Tue, 12 Nov 2002 15:41:03 -0500
From: Mikael Pettersson <mikpe@csd.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15825.26870.393595.356922@kim.it.uu.se>
Date: Tue, 12 Nov 2002 21:47:50 +0100
To: Thomas Molina <tmolina@cox.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5 Problem Report Status for 10 Nov
In-Reply-To: <Pine.LNX.4.44.0211100834110.16968-100000@dad.molina>
References: <Pine.LNX.4.44.0211100834110.16968-100000@dad.molina>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Molina writes:
 >    open   08 Oct 2002 IDE problems on prePCI
 >    3. http://marc.theaimsgroup.com/?l=linux-kernel&m=103277899317468&w=2

No update since I haven't had time to do any qd65xx testing in a while.
I strongly believe the bug is due to the fact that "ide=qd65xx" and
similar IDE chipset selection options are processed very very early in
the boot process, long before IDE's normal init.

 >    open   17 Oct 2002 reboot kills Dell Latitude keyboard
 >   38. http://marc.theaimsgroup.com/?l=linux-kernel&m=103484425027884&w=2

This bug is still present in 2.5.47.

 >    open   08 Nov 2002 piix driver oops
 >   99. http://marc.theaimsgroup.com/?l=linux-kernel&m=103677362411873&w=2

That one is a duplicate of the ide-dma oops I reported:
http://marc.theaimsgroup.com/?l=linux-kernel&m=103675019320066&w=2
Alan stated he had IDE updates that would fix this.

