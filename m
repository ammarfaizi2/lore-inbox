Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262276AbTIUBpe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Sep 2003 21:45:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262277AbTIUBpe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Sep 2003 21:45:34 -0400
Received: from mail003.syd.optusnet.com.au ([211.29.132.144]:37309 "EHLO
	mail003.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S262276AbTIUBpc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Sep 2003 21:45:32 -0400
Subject: threading or setjmp issue on K 2.6  test4
From: Ken Foskey <foskey@optushome.com.au>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1064108728.16535.27.camel@gandalf.foskey.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Sun, 21 Sep 2003 11:45:29 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


For most details see:

http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=210284

Basically there is appears to be threading bug on K 2.6.  The source
attached to the above bug runs correctly on K2.4 and also on many other
platforms.  The source also works correctly if I use the define that
forks instead of threads. It is unlikely that there is a problem with
this code, it is fairly simple.

Could a specialist please look at this problem.  I am using gcc 3.3.2 to
compile both kernel and source.

-- 
Thanks
KenF
OpenOffice.org developer

