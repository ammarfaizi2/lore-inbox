Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267881AbRG0J2J>; Fri, 27 Jul 2001 05:28:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267894AbRG0J17>; Fri, 27 Jul 2001 05:27:59 -0400
Received: from pizda.ninka.net ([216.101.162.242]:9862 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S267881AbRG0J1u>;
	Fri, 27 Jul 2001 05:27:50 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15201.13334.679701.164733@pizda.ninka.net>
Date: Fri, 27 Jul 2001 02:27:50 -0700 (PDT)
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: torrey.hoffman@myrio.com (Torrey Hoffman), nat.ersoz@myrio.com (Nat Ersoz),
        linux-kernel@vger.kernel.org
Subject: Re: IGMP join/leave time variability
In-Reply-To: <E15PpHy-0004Ch-00@the-village.bc.nu>
In-Reply-To: <no.id>
	<E15PpHy-0004Ch-00@the-village.bc.nu>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing


Alan Cox writes:
 > > But this "small interval" is actually very noticeable in our application.
 > 
 > I suspect the small interval for the first one should be 1 not 1*HZ. That
 > would keep a little bit of jitter which is good to avoid the multicast
 > receive/join group problem

I've changed it to "1" in my sources.  Thanks.

Later,
David S. Miller
davem@redhat.com
