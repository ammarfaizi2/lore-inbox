Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130130AbQLUTct>; Thu, 21 Dec 2000 14:32:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129697AbQLUTcj>; Thu, 21 Dec 2000 14:32:39 -0500
Received: from NS2.pcscs.com ([207.96.110.42]:35081 "EHLO linux01.pcscs.com")
	by vger.kernel.org with ESMTP id <S130130AbQLUTcT>;
	Thu, 21 Dec 2000 14:32:19 -0500
Message-ID: <005401c06b80$73f50fc0$2b6e60cf@pcscs.com>
From: "Charles Wilkins" <chas@pcscs.com>
To: "John Covici" <covici@ccs.covici.com>
Cc: "Linux Kernel mailing list" <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.21.0012211324000.7606-100000@ccs.covici.com>
Subject: Re: strange nfs behavior in 2.2.18 and 2.4.0-test12
Date: Thu, 21 Dec 2000 14:01:41 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I can confirm this problem exists in Mandrake-7.2 as well with kernel
2.2.17-21.

----- Original Message -----
From: "John Covici" <covici@ccs.covici.com>
To: <linux-kernel@vger.kernel.org>
Sent: Thursday, December 21, 2000 1:37 PM
Subject: strange nfs behavior in 2.2.18 and 2.4.0-test12


> Hi.  I am having strange nfs problems in both my 2.x and 2.4.0-test12
> kernels.
>
> What is happening is that when the machine boots up and exports the
> directories for nfs, it complains that
>
> ccs2:/ invalid argument .
>
> The exports entry is
>
> / ccs2(rw,no_root_squash)
>
> Now in Kernel 2.2.18, if I stop and restart the nfs daemons, all is
> OK, the invalid argument goes away, but in 2.4.0 I cannot get this to
> work at all and so I cannot mount nfs from a client on the ccs2 box.
> I am using the utilities 0.2.1-4 from the Debian distribution if that
> makes any difference.  I did an strace once on exportfs and it was
> having trouble with the call to nfsservctl which returns invalid argument.
>
>
> Any assistance would be appreciated.
>
> --
>          John Covici
>          covici@ccs.covici.com
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
>

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
