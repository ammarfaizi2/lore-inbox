Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129831AbQLDW0n>; Mon, 4 Dec 2000 17:26:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129183AbQLDW0e>; Mon, 4 Dec 2000 17:26:34 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:57360 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S130083AbQLDW0a>;
	Mon, 4 Dec 2000 17:26:30 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: scole@lanl.gov
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.0-test12-pre4 + cs46xx + KDE 2.0 = frozen system 
In-Reply-To: Your message of "Mon, 04 Dec 2000 14:27:10 PDT."
             <00120414271000.01254@spc.esa.lanl.gov> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 05 Dec 2000 08:55:58 +1100
Message-ID: <4743.975966958@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Dec 2000 14:27:10 -0700, 
Steven Cole <scole@lanl.gov> wrote:
>If I have the cs46xx driver compiled either as a module or into
>the kernel, then 2.4.0-test12-pre4 locks up when KDE 2.0
>is started.
>[snip]
>When I say the system freezes, I mean it completely locks up, and
>ALT-SYSRQ-<whatevercommand> does not do a thing.  The magic
>key combo gives the expected result before freezup.

Try the kdb patch, it is very good at getting data out when a machine
has hung.  You will need a serial console to see kdb output, it does
not work with X.

ftp://oss.sgi.com/projects/kdb/download/ix86/

kdb-v1.6-2.4.0-test11-pre7.gz should still fit 2.4.0-test12-pre4.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
