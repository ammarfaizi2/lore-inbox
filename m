Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131160AbQLIXMa>; Sat, 9 Dec 2000 18:12:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130389AbQLIXMU>; Sat, 9 Dec 2000 18:12:20 -0500
Received: from vega.services.brown.edu ([128.148.19.202]:1433 "EHLO
	vega.brown.edu") by vger.kernel.org with ESMTP id <S131481AbQLIXMF>;
	Sat, 9 Dec 2000 18:12:05 -0500
Message-Id: <4.3.2.7.2.20001209174435.00aaf310@postoffice.brown.edu>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Sat, 09 Dec 2000 17:46:16 -0500
To: linux-kernel@vger.kernel.org
From: David Feuer <David_Feuer@brown.edu>
Subject: Re: swapoff weird
In-Reply-To: <20001209222427.A1542@bug.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 10:24 PM 12/9/2000 +0100, you wrote:d
>It is possible to remove swapfile in use. Great, but how do you swap
>off then? Who is to blame?

Perhaps it would be good to put a check in unlink to make sure that this is 
not the last link to a swapfile.  Are there any other sorts of files that 
don't belong to any user process and may remain active after unlink?

--
This message has been brought to you by the letter alpha and the number pi.
Open Source: Think locally; act globally.
David Feuer
David_Feuer@brown.edu

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
