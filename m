Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129945AbRBHMi3>; Thu, 8 Feb 2001 07:38:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131163AbRBHMiT>; Thu, 8 Feb 2001 07:38:19 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:42250 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129945AbRBHMiM>; Thu, 8 Feb 2001 07:38:12 -0500
Subject: Re: Problem with schedule_timeout..
To: avyas@cse.iitk.ac.in (Avinash vyas)
Date: Thu, 8 Feb 2001 12:38:22 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org, kernelnewbies@humbolt.nl.linux.org,
        ak@cse.iitk.ac.in ("Atul Kumar (9721171)"),
        rajiva@cse.iitk.ac.in (Rajiv A.R)
In-Reply-To: <Pine.LNX.4.10.10102081745140.758-100000@csews5.cse.iitk.ac.in> from "Avinash vyas" at Feb 08, 2001 05:55:56 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14QqLB-0003RI-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 	I am a relatively newb in the kenel programming. I am using the
> function "schedule_timeout" for sleeping for some time. But in some cases
> the function returns after the specified timeout but in some instance it
> returns immediately, without decrementing the timeout value passed as the
> argument. 

Make sure you have the task set to be in interruptible or uninterrutible
sleep before you do the schedule_timeout

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
