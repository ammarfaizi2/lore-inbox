Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263169AbRFEDxs>; Mon, 4 Jun 2001 23:53:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263177AbRFEDxi>; Mon, 4 Jun 2001 23:53:38 -0400
Received: from pizda.ninka.net ([216.101.162.242]:39326 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S263169AbRFEDxf>;
	Mon, 4 Jun 2001 23:53:35 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15132.22458.908923.125958@pizda.ninka.net>
Date: Mon, 4 Jun 2001 20:53:30 -0700 (PDT)
To: Darryl Miles <darryl@netbauds.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: TCP Connection lockup between 2.4.0 and 2.4.5
In-Reply-To: <3B1C5682.6BBD40BC@netbauds.net>
In-Reply-To: <3B1C5682.6BBD40BC@netbauds.net>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Darryl Miles writes:
 > It appears the .218 end stops ACKing, even though it is obviously seeing
 > the data come in, since the TCPDUMP is from the .218 host.  I've been
 > running 2.4.0 on 10.0.0.218 since 9th Jan and can't believe that this
 > problem is a bug in 2.4.0, since it was speaking with the .219 box all
 > this time until I recently updated the .219 end from 2.0.32 to 2.4.5
 > over last weekend.

Believe it or not, it is likely a bug in 2.4.0 :-)  2.4.0 has several
major TCP failures, not fixed until 2.4.4/2.4.5.

Later,
David S. Miller
davem@redhat.com
