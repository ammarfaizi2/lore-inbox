Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131341AbQKJWKW>; Fri, 10 Nov 2000 17:10:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131429AbQKJWKN>; Fri, 10 Nov 2000 17:10:13 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:29188 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S131341AbQKJWKC>; Fri, 10 Nov 2000 17:10:02 -0500
Message-ID: <3A0C7139.DDD81E67@timpanogas.org>
Date: Fri, 10 Nov 2000 15:05:45 -0700
From: "Jeff V. Merkey" <jmerkey@timpanogas.org>
Organization: TRG, Inc.
X-Mailer: Mozilla 4.7 [en] (WinNT; I)
X-Accept-Language: en
MIME-Version: 1.0
To: sendmail-bugs@Sendmail.ORG
CC: linux-kernel@vger.kernel.org
Subject: Re: sendmail fails to deliver mail with attachments in /var/spool/mqueue
In-Reply-To: <3A0C3F30.F5EB076E@timpanogas.org> <20001110133431.A16169@sendmail.com> <3A0C6B7C.110902B4@timpanogas.org> <3A0C6E01.EFA10590@timpanogas.org> <26054.973893835@euclid.cs.niu.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Then perhaps qmail's time has finally come .... If sendmail cannot run
on a machine with minimal background loading from a dozen or so FTP
clients downloading files, it's clearly sick.  BTW.  I have another box
running qmail, and it doesn't have these problems.

Jeff

Neil W Rickert wrote:
> 
> "Jeff V. Merkey" <jmerkey@timpanogas.org> wrote:
> 
> >The problem of dropping connections on 2.4 was related to the O RefuseLA
> >settings.  The defaults  in the RedHat, Suse, and OpenLinux RPMs are
> >clearly set too low for modern Linux kernels.  You may want them cranked
> >up to 100 or something if you want sendmail to always work.
> 
> If a modern Linux kernel requires high load average defaults, I will
> stop using Linux.
> 
>  -NWR
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
