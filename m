Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262690AbTHaVMl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Aug 2003 17:12:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262695AbTHaVMk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Aug 2003 17:12:40 -0400
Received: from mail.wlanmail.com ([194.100.155.139]:8968 "HELO
	mail.wlanmail.com") by vger.kernel.org with SMTP id S262690AbTHaVMk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Aug 2003 17:12:40 -0400
From: Joonas Koivunen <rzei@mbnet.fi>
Reply-To: rzei@mbnet.fi
To: linux-kernel@vger.kernel.org
Subject: O18.1int problems
Date: Mon, 1 Sep 2003 00:12:53 +0300
User-Agent: KMail/1.5.9
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200309010012.53716.rzei@mbnet.fi>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

after reading some mails and discussion about Con Kolivas' patches I decided 
to give a try. Got latest (-test4) vanilla and applied patch-test4-O18.1int. 
Desktop (kde pre 3.2) runs smoother than with vanilla 2.6.0-test3.

But when I tried to recompile my kde sources (first updating from cvs) 
starting with rebuilding makefile templates (make -f Makefile.cvs) (some 
autoconf/automake stuff, don't really know :) it froze. In Konsole window I 
tried ctrl-c, ctrl-d, no effect. A brief ps aux | grep make shows that make 
is in D state and so is it's find task. This D state didn't clear in 24 
houres and I seem to be unable of reproducing it under vanilla 2.6.0-test4. 
Killing of those processes didn't work (though I'm not sure if it should kill 
those instantly).

Is this problem with my configuration or some sneaky bug? System had been up 
some time (24-48 houres) so I'll try reproducing it later also.

-rzei
