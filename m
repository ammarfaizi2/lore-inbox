Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130198AbQKMXuk>; Mon, 13 Nov 2000 18:50:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130258AbQKMXub>; Mon, 13 Nov 2000 18:50:31 -0500
Received: from [47.140.48.50] ([47.140.48.50]:30894 "EHLO
	zrtps06s.us.nortel.com") by vger.kernel.org with ESMTP
	id <S130251AbQKMXuQ>; Mon, 13 Nov 2000 18:50:16 -0500
Message-ID: <3A1070D5.FA0462EC@nortelnetworks.com>
Date: Mon, 13 Nov 2000 17:53:09 -0500
From: "Christopher Friesen" <cfriesen@nortelnetworks.com>
X-Mailer: Mozilla 4.7 [en] (X11; U; HP-UX B.10.20 9000/778)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: quick question regarding system time
In-Reply-To: <NBBBJGOOMDFADJDGDCPHKEJDCJAA.law@sgi.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Orig: <cfriesen@americasm01.nt.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm working on some timer routines to allow arbitrary numbers of timers
all based off the single real timer provided by "setitimer".  However, I
haven't been able to figure out from the documentation what happens to
the countdown timer used by setitimer when the system clock is changed
(by root, for instance).  If I move the system clock forward or backward
a few seconds, is the itimer affected by this at all (I hope not) or can
I simply ignore it (I hope so).

Thanks,

Chris

-- 
Chris Friesen                    | MailStop: 043/33/F10  
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
