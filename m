Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129927AbQLYQVM>; Mon, 25 Dec 2000 11:21:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131598AbQLYQVC>; Mon, 25 Dec 2000 11:21:02 -0500
Received: from smtp01.mrf.mail.rcn.net ([207.172.4.60]:12002 "EHLO
	smtp01.mrf.mail.rcn.net") by vger.kernel.org with ESMTP
	id <S129927AbQLYQUw>; Mon, 25 Dec 2000 11:20:52 -0500
Message-ID: <3A476CC0.45AD0033@haque.net>
Date: Mon, 25 Dec 2000 10:50:24 -0500
From: "Mohammad A. Haque" <mhaque@haque.net>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test13-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Dave Gilbert <gilbertd@treblig.org>, linux-kernel@vger.kernel.org
Subject: Re: css hang; somewhere between test12 and test13pre4ac2
In-Reply-To: <Pine.LNX.4.10.10012242340530.666-100000@tardis.home.dave> <20001225121037.B303@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is confirmed. mounting css dics causes oops. non-css discs work
fine. 

oops coming soon.

Jens Axboe wrote:
> The most likely suspect (as someone else pointed out) is not at
> all css (I'm not even sure what you mean by css hang?) but UDF.
> Given the fs changes. Since sysrq still works, it would help a
> lot if you could capture sysrq-p repeatedly and send it in.
> 
> Do you have any non-css discs to beat on UDF?
> 
> --
> * Jens Axboe <axboe@suse.de>
> * SuSE Labs
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/

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
