Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130201AbQJaEhC>; Mon, 30 Oct 2000 23:37:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130235AbQJaEgw>; Mon, 30 Oct 2000 23:36:52 -0500
Received: from [63.95.87.168] ([63.95.87.168]:1808 "HELO xi.linuxpower.cx")
	by vger.kernel.org with SMTP id <S130201AbQJaEgj>;
	Mon, 30 Oct 2000 23:36:39 -0500
Date: Mon, 30 Oct 2000 23:36:38 -0500
From: Gregory Maxwell <greg@linuxpower.cx>
To: Carl Perry <caperry@edolnx.net>
Cc: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: Is IPv4 totally broken in 2.4-test
Message-ID: <20001030233638.A29893@xi.linuxpower.cx>
In-Reply-To: <39FE5C09.F1B13725@edolnx.net> <200010310404.UAA05392@pizda.ninka.net> <39FE5E75.91BEBD0@edolnx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.8i
In-Reply-To: <39FE5E75.91BEBD0@edolnx.net>; from caperry@edolnx.net on Mon, Oct 30, 2000 at 11:53:57PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2000 at 11:53:57PM -0600, Carl Perry wrote:
> Duh.  And here I was thinking that was a good thing.  That did it.  What exactly
> does "Explicit Congestion Notification" do?  I figured it was going to put a
> message in syslog if the wire is full and packets were being dropped.  There
> weren't any docs in menuconfig - so I figured "what the hey?".  Boy - I was
> wrong.  Thanks for the quick response.  I haven't even gotten the post back yet.

The sites are broken. They are running crap firewalls (often Cisco) that
probably haven't been updated (or have no update available), and they see the
(perfectly standards compliant) 'I support ECN' flag, think it must be
something evil and drop the packet silently.

ECN is an important factor for the future scalability of the Internet. It
allows for much smarter methods for congestion control. It's important that
it get implemented, but these crappy firewalls are standing in the way.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
