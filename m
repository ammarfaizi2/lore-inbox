Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129367AbRAZDXO>; Thu, 25 Jan 2001 22:23:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130149AbRAZDXF>; Thu, 25 Jan 2001 22:23:05 -0500
Received: from Huntington-Beach.Blue-Labs.org ([208.179.0.198]:36683 "EHLO
	Huntington-Beach.Blue-Labs.org") by vger.kernel.org with ESMTP
	id <S129367AbRAZDW6>; Thu, 25 Jan 2001 22:22:58 -0500
Message-ID: <3A70EC60.F2974680@linux.com>
Date: Fri, 26 Jan 2001 03:17:52 +0000
From: David Ford <david@linux.com>
Organization: Blue Labs Software
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Michael B. Trausch" <fd0man@crosswinds.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: ECN and other sites
In-Reply-To: <Pine.LNX.4.21.0101252215070.4411-100000@fd0man.accesstoledo.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Michael B. Trausch" wrote:

> I've kinda been watching the ECN discussion there, and I have 2.4.0 and
> noticed that after I'd installed it, I couldn't get to my favorite search
> engine (Dogpile.com).  I'd assume they don't support it either, because
> when I "echo 0 > /proc/sys/net/ipv4/tcp_ecn" then it goes away.  I
> notified them about the problem and pointed them to a few webpages with
> information and links regarding ECN.
>
> Is there a kernel config option somewhere to disable that, or do I just
> need to make sure to put that echo line in my /etc/rc.d/rc.local?

Yes, you enabled it in the networking options.  CONFIG_INET_ECN.

-d

--
  There is a natural aristocracy among men. The grounds of this are virtue and talents. Thomas Jefferson
  The good thing about standards is that there are so many to choose from. Andrew S. Tanenbaum



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
