Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129455AbQLYQUC>; Mon, 25 Dec 2000 11:20:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129927AbQLYQTw>; Mon, 25 Dec 2000 11:19:52 -0500
Received: from smtp01.mrf.mail.rcn.net ([207.172.4.60]:58081 "EHLO
	smtp01.mrf.mail.rcn.net") by vger.kernel.org with ESMTP
	id <S129455AbQLYQTq>; Mon, 25 Dec 2000 11:19:46 -0500
Message-ID: <3A476C7D.1952EDB4@haque.net>
Date: Mon, 25 Dec 2000 10:49:18 -0500
From: "Mohammad A. Haque" <mhaque@haque.net>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test13-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Frank Jacobberger <f1j@xmission.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: test13-pre4... udf problem with dvd access vs test12
In-Reply-To: <3A47212D.F9F119C3@xmission.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just captured the oops.

It happens when you try to mount (mount -t udf /dev/foo /mnt/bar) an
encrypted dvd. At least it does on my end. Unencrypted dvds mount fine.

ksymoops coming soon.

Frank Jacobberger wrote:
> 
> Odd happening here. Been running good as gold through test12 with
> accessing my dvd to using oms. Now updating to test13-pre4
> I get a complete lock up of my whole system when executing oms.
> 
> I can access the drive via mounting it... with no trouble what ever.
> 
> Here is a snip from my message file.... No clue what to test for here...
> 
> Perhaps udf.c is the problem?
> 
> Any ideas?

-- 

=====================================================================
Mohammad A. Haque                              http://www.haque.net/ 
                                               mhaque@haque.net

  "Alcohol and calculus don't mix.             Project Lead
   Don't drink and derive." --Unknown          http://wm.themes.org/
                                               batmanppc@themes.org
=====================================================================
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
