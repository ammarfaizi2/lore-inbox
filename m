Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317023AbSGIQlb>; Tue, 9 Jul 2002 12:41:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317300AbSGIQla>; Tue, 9 Jul 2002 12:41:30 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:45540 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S317023AbSGIQl3>;
	Tue, 9 Jul 2002 12:41:29 -0400
Subject: 2.4.19-rc1 sending SIGALRM to exec'd process
From: Paul Larson <plars@austin.ibm.com>
To: Marcelo Tosati <marcelo@conectiva.com.br>
Cc: lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 09 Jul 2002 11:33:41 -0500
Message-Id: <1026232422.32159.3.camel@plars.austin.ibm.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.4.19-rc1 seems to be having trouble sending a SIGALRM process that
have been exec'd on one of my test boxes.  From the Linux Test Project,
alarm04 test:

sig_rev     1  FAIL  :  alarm() fails to send SIGALRM to execed
                                  process

Also, the gettimeofday02 test fails when execed from the test driver,
but not when you run it alone.  This test also sends a SIGALRM to know
when it's done.

Machine is a PIII-600

Thanks,
Paul Larson

