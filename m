Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266915AbSKVHlX>; Fri, 22 Nov 2002 02:41:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266955AbSKVHlX>; Fri, 22 Nov 2002 02:41:23 -0500
Received: from 205-158-62-68.outblaze.com ([205.158.62.68]:50448 "HELO
	spf0.us4.outblaze.com") by vger.kernel.org with SMTP
	id <S266915AbSKVHlX>; Fri, 22 Nov 2002 02:41:23 -0500
Message-ID: <20021122074154.25171.qmail@email.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "dan carpenter" <error27@email.com>
To: steve@kbuxd.necst.nec.co.jp
Cc: linux-kernel@vger.kernel.org, smatch-kbugs@lists.sourceforge.net,
       kernel-janitor-discuss@lists.sourceforge.net
Date: Fri, 22 Nov 2002 02:41:54 -0500
Subject: Re: [LIST] large local declarations
X-Originating-Ip: 67.112.122.250
X-Originating-Server: ws3-5.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: SL Baur <steve@kbuxd.necst.nec.co.jp>

> dan carpenter writes:
> > The function with the largest variable is riocontrol().  It is used
> > deliberately for some weird hardware.  According to the comment,
> > "it's hardware like this that really gets on [the author's] tits."
> 
> > 524736	 drivers/char/rio/rioctrl.c 1784 riocontrol
> 
> That variable is static.
> 

Ah...  I did not know that matterred.
Probably a lot of the other variables on the list are as well.

It will take me a couple days to create a new list that takes
static variables into consideration.

regards,
dan carpenter


-- 
_______________________________________________
Sign-up for your own FREE Personalized E-mail at Mail.com
http://www.mail.com/?sr=signup

One click access to the Top Search Engines
http://www.exactsearchbar.com/mailcom

