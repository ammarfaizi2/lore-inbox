Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132323AbQLHXDK>; Fri, 8 Dec 2000 18:03:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132422AbQLHXDA>; Fri, 8 Dec 2000 18:03:00 -0500
Received: from host55.osagesoftware.com ([209.142.225.55]:1295 "EHLO
	netmax.osagesoftware.com") by vger.kernel.org with ESMTP
	id <S132323AbQLHXCn>; Fri, 8 Dec 2000 18:02:43 -0500
Message-Id: <4.3.2.7.2.20001208171903.00c31250@mail.osagesoftware.com>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Fri, 08 Dec 2000 17:31:51 -0500
To: Peter Berger <peterb@telerama.com>
From: David Relson <relson@osagesoftware.com>
Subject: Re: Pthreads, linux, gdb, oh my! (fwd)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.BSI.4.02.10012081708350.130-100000@frogger.telerama.c
 om>
In-Reply-To: <F1BEC884C26@vcnet.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Petr,

It ran fine on my stock Mandrake 7.2 system - linux-2.2.17-21mdk and 
glibc-2.2-5mdk.  The program ran fine in both environments - command line 
and gdb-5.0.  Loadavg creeps up slowly as the program continues to run.  At 
thread #37000, loadavb is 3.65.  The ps command indicates 4 threads for the 
program (including gdb).

David

At 05:15 PM 12/8/00, Peter Berger wrote:

>Petr,
>
>Thanks for testing this and finding a working counterexample!  I am still
>professionally interested to know if the difference is that you are
>running a 2.4 kernel, or the glibc.  Anyone running a 2.2 kernel with
>glibc 2.2 want to drop me a line?
>
>-Peter

--------------------------------------------------------
David Relson                   Osage Software Systems, Inc.
relson@osagesoftware.com       514 W. Keech Ave.
www.osagesoftware.com          Ann Arbor, MI 48103
voice: 734.821.8800            fax: 734.821.8800

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
