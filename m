Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129406AbRAJBXx>; Tue, 9 Jan 2001 20:23:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129431AbRAJBXn>; Tue, 9 Jan 2001 20:23:43 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:61452 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S129406AbRAJBXX>;
	Tue, 9 Jan 2001 20:23:23 -0500
Message-ID: <3A5BB985.8A249BE1@mandrakesoft.com>
Date: Tue, 09 Jan 2001 20:23:17 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1-pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: Updated zerocopy patch up on kernel.org
In-Reply-To: <200101100055.QAA07674@pizda.ninka.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" wrote:
> 
> Nothing interesting or new, just merges up with the latest 2.4.1-pre1
> patch from Linus.
> 
> ftp.kernel.org:/pub/linux/kernel/people/davem/zerocopy-2.4.1p1-1.diff.gz
> 
> I haven't had any reports from anyone, which must mean that it is
> working perfectly fine and adds no new bugs, testers are thus in
> nirvana and thus have nothing to report.  :-)

Is there any value to supporting fragments in a driver which doesn't do
hardware checksumming?  IIRC Alexey had a patch to do such for Tulip,
but I don't see it in the above patchset.

	Jeff


-- 
Jeff Garzik       | "You see, in this world there's two kinds of
Building 1024     |  people, my friend: Those with loaded guns
MandrakeSoft      |  and those who dig. You dig."  --Blondie
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
