Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129675AbRALD5e>; Thu, 11 Jan 2001 22:57:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129742AbRALD5Y>; Thu, 11 Jan 2001 22:57:24 -0500
Received: from gherkin.sa.wlk.com ([192.158.254.49]:4 "HELO gherkin.sa.wlk.com")
	by vger.kernel.org with SMTP id <S129675AbRALD5K>;
	Thu, 11 Jan 2001 22:57:10 -0500
Message-Id: <m14GvKu-0005keC@gherkin.sa.wlk.com>
From: rct@gherkin.sa.wlk.com (Bob_Tracy)
Subject: depmod -a and 2.4.0
To: linux-kernel@vger.kernel.org
Date: Thu, 11 Jan 2001 21:57:08 -0600 (CST)
X-Mailer: ELM [version 2.4ME+ PL82 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Maybe I missed the discussion, but why might "depmod -a" result
in every module getting installed?  This didn't happen under any
of the 2.4.0-testX releases that I recall, and I ran every one of
those and the prerelease without this "trouble".  Gotta say, the
screen output from running "lsmod" with everything installed is
pretty darned impressive :-).  Another oddity that someone else
already reported: the ipv6 module shows a reference count of -1.

Yes, I'm running modutils-2.4.1, and I get the same results with
modutils-2.3.15.

-- 
Bob Tracy                                            rct@frus.com
-----------------------------------------------------------------
 "We might not be in hell, but we can see the gates from here."
 --Phoenix resident, Summer of 2000
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
