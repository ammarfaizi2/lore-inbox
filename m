Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130484AbQKAQ1t>; Wed, 1 Nov 2000 11:27:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131248AbQKAQ1i>; Wed, 1 Nov 2000 11:27:38 -0500
Received: from mta6.snfc21.pbi.net ([206.13.28.240]:23718 "EHLO
	mta6.snfc21.pbi.net") by vger.kernel.org with ESMTP
	id <S130484AbQKAQ1X>; Wed, 1 Nov 2000 11:27:23 -0500
Date: Wed, 01 Nov 2000 08:29:48 -0800
From: Dan Kegel <dank@alumni.caltech.edu>
Subject: Re: Linus's poll variation
To: linux-kernel@vger.kernel.org, Lyle Coder <lcoder@webunwired.com>
Reply-to: dank@alumni.caltech.edu
Message-id: <3A0044FC.DEE2C02@alumni.caltech.edu>
MIME-version: 1.0
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.14-5.0 i686)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
X-Accept-Language: en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lyle asked:
> Is someone working on Linus's poll variation discussed in this list a week ago? 

I think the interface still needs some discussion.
The interface Linus proposed is IMHO oriented towards ease of 
kernel implementation, and doesn't appear to be easy to use
for all applications.
cf. recent posts by John Gardiner Myers <jgmyers@netscape.com>
e.g. 
http://boudicca.tux.org/hypermail/linux-kernel/2000week44/0966.html
http://boudicca.tux.org/hypermail/linux-kernel/2000week45/0212.html
IMHO kqueue()/kevent() is closer to what the apps want.

Mike Jagdis, however, has done some work on speeding up the
existing poll() system call, and has an eye on implementing
the /dev/poll interface.  See
http://boudicca.tux.org/hypermail/linux-kernel/2000week45/0266.html
- Dan
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
