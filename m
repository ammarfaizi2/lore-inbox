Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278327AbRJSK3x>; Fri, 19 Oct 2001 06:29:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278359AbRJSK3n>; Fri, 19 Oct 2001 06:29:43 -0400
Received: from mail-01.med.umich.edu ([141.214.93.149]:12426 "EHLO
	mail-01.med.umich.edu") by vger.kernel.org with ESMTP
	id <S278356AbRJSK3c> convert rfc822-to-8bit; Fri, 19 Oct 2001 06:29:32 -0400
Message-Id: <sbcfc887.096@mail-01.med.umich.edu>
X-Mailer: Novell GroupWise Internet Agent 6.0
Date: Fri, 19 Oct 2001 06:29:59 -0400
From: "Nicholas Berry" <nikberry@med.umich.edu>
To: <linux-kernel@vger.kernel.org>, <x55k@yahoo.com>
Subject: Re: UNABLE TO BOOT WITH 2nd SCSI DRIVE
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well, I can see a problem. You say the IBM is ID 0.

The driver says it's ID 6. That means your new drive, as ID1, will become sda.

I think the jumper is wrong on your IBM.

Nik


>>> jimmy <x55k@yahoo.com> 10/19/01 05:55AM >>>
Hello Russell,

> You've given all the information for the case that
> works, but no information
> about the case that doesn't work.

That is because the server is 8000 miles away from me
(other side of the contient) and I am unable to obtain
all the error messages except the kernel panic (last).

FYI, /dev/sda had ID:0 (old drive) and new drive had
ID:1. I have tried all ID configurations but nothing
worked on 2 drive system.

> What whould be really useful is the above message
> fragment for the case
> where it doesn't boot, particularly which drives
> it's seeing and the
> order it's seeing them.

It might also be helpful to note that the following
error shows for both drives before kernel panic:

"parity error detected in Data-in phase"

So, I assume the order of drives are fine. I am
clueless.

Many thanks.

Jimmy

PS: yahoo is being rejected by your mail server.

__________________________________________________
Do You Yahoo!?
Make a great connection at Yahoo! Personals.
http://personals.yahoo.com 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org 
More majordomo info at  http://vger.kernel.org/majordomo-info.html 
Please read the FAQ at  http://www.tux.org/lkml/

