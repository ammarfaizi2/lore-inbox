Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131094AbQKRFJh>; Sat, 18 Nov 2000 00:09:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131219AbQKRFJ1>; Sat, 18 Nov 2000 00:09:27 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:30988 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S131094AbQKRFJM>;
	Sat, 18 Nov 2000 00:09:12 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Tigran Aivazian <tigran@aivazian.fsnet.co.uk>
cc: linux-kernel@vger.kernel.org, kdb@oss.sgi.com, aprasad@in.ibm.com
Subject: Re: test11-pre6 still very broken 
In-Reply-To: Your message of "Fri, 17 Nov 2000 20:00:49 -0000."
             <Pine.LNX.4.21.0011171935560.1796-100000@saturn.homenet> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 18 Nov 2000 15:38:59 +1100
Message-ID: <20616.974522339@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Nov 2000 20:00:49 +0000 (GMT), 
Tigran Aivazian <tigran@aivazian.fsnet.co.uk> wrote:
>The mysterious lockups in test11-pre5 continue in test11-pre6. It is very
>difficult because the lockups appear to be kdb-specific (and kdb itself
>goes mad) but when there is no kdb there is very little useful information
>one can extract from a dead system...

ftp://oss.sgi.com/projects/kdb/download/ix86/kdb-v1.6-2.4.0-test11-pre7.gz

Assorted bug fixes from my work in progress tree, including one that
fixes a race between user space use of debug and kdb, ltrace trips this.

Some people have reported keyboard lockups after leaving kdb.  I have
not been able to reproduce this problem, let me know if you still see
it.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
