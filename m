Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932172AbWEWLBs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932172AbWEWLBs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 07:01:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932173AbWEWLBs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 07:01:48 -0400
Received: from ns.dynamicweb.hu ([195.228.155.139]:49835 "EHLO dynamicweb.hu")
	by vger.kernel.org with ESMTP id S932172AbWEWLBr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 07:01:47 -0400
Message-ID: <01a101c67e58$38cdc8b0$1800a8c0@dcccs>
From: =?ISO-8859-1?Q?Haar_J=E1nos?= <djani22@netcenter.hu>
To: "Nick Piggin" <nickpiggin@yahoo.com.au>
Cc: <kernel@kolivas.org>, <cw@f00f.org>, <linux-kernel@vger.kernel.org>
References: <00e901c67cad$fe9a9d90$1800a8c0@dcccs> <200605222117.27433.kernel@kolivas.org> <031001c67db1$a8c4a1e0$1800a8c0@dcccs> <200605230112.45564.kernel@kolivas.org> <047401c67de3$a05a52c0$1800a8c0@dcccs> <4472D327.3060808@yahoo.com.au> <013601c67e51$eef03c10$1800a8c0@dcccs> <4472E2E0.4000201@yahoo.com.au> <018401c67e54$1043cfb0$1800a8c0@dcccs> <4472E7E4.6060403@yahoo.com.au>
Subject: Re: swapper: page allocation failure. - random reboot problem
Date: Tue, 23 May 2006 13:01:07 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: 8bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1437
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


----- Original Message ----- 
From: "Nick Piggin" <nickpiggin@yahoo.com.au>
To: "Haar János" <djani22@netcenter.hu>
Cc: <kernel@kolivas.org>; <cw@f00f.org>; <linux-kernel@vger.kernel.org>
Sent: Tuesday, May 23, 2006 12:45 PM
Subject: Re: swapper: page allocation failure. - random reboot problem


> Haar János wrote:
> > ----- Original Message ----- 
>
> >>But is the power supply rated enough to support all the drives?
> >>I have seen random reboots where the power supply wasn't good
> >>enough.
> >
> >
> > This is the 3rd modell, currently 550W.
> > The system is P4 3G.
> >
> > The another 2 stable node uses only 460W, and all hardware is equal.
> > But i tried to swap ps between the stable and unstabe nodes, but nothing
is
> > changed....
>
> Not sure then, sorry.

OK, what do you recommend? :-)


>
> If it is a software problem, then if you can narrow it down further
> (eg. kernel 2.6.15 worked, 2.6.16 did not), or find a reproducable
> test case for it, then some more progress might be made.

Yes, you have right!
I try it allready, but i cannot step back enough, because my sata card works
only on 2.6.16+

Before i use the promise sata cards, and the sata 300G hdds, i use 2.6.15
kernel, and all my 4 nodes was really stable.
But this is not enough to exactly find the problem. :-(

Anyway, Hetbert Xu helps me a lot to track down the problem, but we only can
close out some thing.
If i have right, the problem is about libata, promise driver,
sata-error-handling or similar, but not so sure.

If there is no way to software debug, i will swap all the 12 hdd between 2
disk nodes, and this can show i have right, or not.

Cheers,
Janos

>
> -- 
> SUSE Labs, Novell Inc.
> Send instant messages to your online friends http://au.messenger.yahoo.com

