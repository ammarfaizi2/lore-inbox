Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291148AbSBLQJB>; Tue, 12 Feb 2002 11:09:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291150AbSBLQIx>; Tue, 12 Feb 2002 11:08:53 -0500
Received: from rzfoobar.is-asp.com ([217.11.194.155]:8617 "HELO mail.isg.de")
	by vger.kernel.org with SMTP id <S291148AbSBLQIi>;
	Tue, 12 Feb 2002 11:08:38 -0500
Message-ID: <3C693DFF.E4C6F0AA@isg.de>
Date: Tue, 12 Feb 2002 17:08:31 +0100
From: Stefan Rompf <srompf@isg.de>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.16 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: "David L. Parsley" <parsley@roanoke.edu>, Andi Kleen <ak@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: Interface operative status detection
In-Reply-To: <3C498CC9.6FAED2AF@isg.de.suse.lists.linux.kernel> <p73g0525je4.fsf@oldwotan.suse.de> <3C692C1C.7090107@roanoke.edu> <3C693BA0.43104E47@nortelnetworks.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> Now what I would *really* like to see would be a way to get asynchronous
> notification of userspace processes on link beat change.   Of course, depending
> on NIC this would require an interrupt handler or a kernel thread periodically
> checking the link state, as well as some way to pass that information to the
> user (netlink socket, interrupt...not sure what the best would be).

I have already written code that sends a link state notification via
netlink socket, but still have to create the patches for 2.5, maybe
2.4ac and later 2.4. Just give me some more days, if you're working as a
software developer in your daily job, you are not always motivated to
run straight to your private computer afterworks, at least I am not ;-)

Stefan
