Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131541AbQKJVQg>; Fri, 10 Nov 2000 16:16:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131739AbQKJVQ0>; Fri, 10 Nov 2000 16:16:26 -0500
Received: from natted.Sendmail.COM ([63.211.143.38]:23865 "EHLO
	wiz.Sendmail.COM") by vger.kernel.org with ESMTP id <S131541AbQKJVQV>;
	Fri, 10 Nov 2000 16:16:21 -0500
Date: Fri, 10 Nov 2000 13:16:04 -0800
From: Claus Assmann <sendmail+ca@sendmail.org>
To: Davide Libenzi <davidel@xmail.virusscreen.com>
Cc: sendmail-bugs@sendmail.org, "Jeff V. Merkey" <jmerkey@timpanogas.org>,
        root@chaos.analogic.com, Andrea Arcangeli <andrea@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [Fwd: sendmail fails to deliver mail with attachments in /var/spool/mqueue]
Message-ID: <20001110131604.A16076@sendmail.com>
Reply-To: sendmail-bugs@sendmail.org
In-Reply-To: <Pine.LNX.3.95.1001110153916.6334A-100000@chaos.analogic.com> <3A0C5EDC.3F30BE9C@timpanogas.org> <20001110125902.A16027@sendmail.com> <00111023290401.00203@linux1.home.bogus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <00111023290401.00203@linux1.home.bogus>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 10, 2000, Davide Libenzi wrote:

[Please use a MTA that sends the e-mail only once to a given machine,
we got three copies of this]

> On Fri, 10 Nov 2000, Claus Assmann wrote:
> > On Fri, Nov 10, 2000, Jeff V. Merkey wrote:
> > > Looks like your bug.  As an FYI, sendmail.rpms in Suse, RedHat, and
> > > OpenLinux all exhibit this behavior, which means they're all broken. 
> > 
> > Sorry, this is plain wrong. sendmail does NOT read the entire
> > file into memory.
> 
> Does sendmail use sendfile() ?

No. Just do a grep on the source code.

I suspect that procmail is used which actually used to load
the entire mail into memory.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
