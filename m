Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130145AbRBZFOT>; Mon, 26 Feb 2001 00:14:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130152AbRBZFOK>; Mon, 26 Feb 2001 00:14:10 -0500
Received: from pizda.ninka.net ([216.101.162.242]:28568 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S130145AbRBZFOC>;
	Mon, 26 Feb 2001 00:14:02 -0500
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15001.58694.597925.420675@pizda.ninka.net>
Date: Sun, 25 Feb 2001 21:10:30 -0800 (PST)
To: Bob Felderman <feldy@myri.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: possible bug x86 2.4.2 SMP in IP receive stack
In-Reply-To: <200102232213.OAA20842@myri.com>
In-Reply-To: <200102232213.OAA20842@myri.com>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Sounds like a bug wrt. SKB allocations in the Myrinet driver.

You're the author of most of that code, so I'm sure you're the
best one to audit it :-)

Later,
David S. Miller
davem@redhat.com
