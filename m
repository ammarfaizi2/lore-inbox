Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131708AbQKJVMG>; Fri, 10 Nov 2000 16:12:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131713AbQKJVL4>; Fri, 10 Nov 2000 16:11:56 -0500
Received: from [151.4.188.87] ([151.4.188.87]:7172 "HELO home.bogus")
	by vger.kernel.org with SMTP id <S131708AbQKJVLn>;
	Fri, 10 Nov 2000 16:11:43 -0500
From: Davide Libenzi <davidel@xmail.virusscreen.com>
To: sendmail-bugs@sendmail.org, Claus Assmann <sendmail+ca@sendmail.org>,
        "Jeff V. Merkey" <jmerkey@timpanogas.org>
Subject: Re: [Fwd: sendmail fails to deliver mail with attachments in /var/spool/mqueue]
Date: Fri, 10 Nov 2000 23:28:29 +0100
X-Mailer: KMail [version 1.0.28]
Content-Type: text/plain; charset=US-ASCII
Cc: root@chaos.analogic.com, Andrea Arcangeli <andrea@suse.de>,
        linux-kernel@vger.kernel.org, sendmail-bugs@sendmail.org
In-Reply-To: <Pine.LNX.3.95.1001110153916.6334A-100000@chaos.analogic.com> <3A0C5EDC.3F30BE9C@timpanogas.org> <20001110125902.A16027@sendmail.com>
In-Reply-To: <20001110125902.A16027@sendmail.com>
MIME-Version: 1.0
Message-Id: <00111023290401.00203@linux1.home.bogus>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Nov 2000, Claus Assmann wrote:
> On Fri, Nov 10, 2000, Jeff V. Merkey wrote:
> > Looks like your bug.  As an FYI, sendmail.rpms in Suse, RedHat, and
> > OpenLinux all exhibit this behavior, which means they're all broken. 
> 
> Sorry, this is plain wrong. sendmail does NOT read the entire
> file into memory.

Does sendmail use sendfile() ?


- Davide
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
