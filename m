Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281152AbRKENuL>; Mon, 5 Nov 2001 08:50:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281153AbRKENuA>; Mon, 5 Nov 2001 08:50:00 -0500
Received: from pizda.ninka.net ([216.101.162.242]:58497 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S281152AbRKENtu>;
	Mon, 5 Nov 2001 08:49:50 -0500
Date: Mon, 05 Nov 2001 05:49:17 -0800 (PST)
Message-Id: <20011105.054917.21928205.davem@redhat.com>
To: kszysiu@main.braxis.co.uk
Cc: linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com
Subject: Re: 2.4.14-pre7 KERNEL: assertion (sk->pprev==NULL) failed at
 tcp_ipv4.c(345):__tcp_v4_hash
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20011105143508.A1327@main.braxis.co.uk>
In-Reply-To: <20011105143508.A1327@main.braxis.co.uk>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Krzysztof Rusocki <kszysiu@main.braxis.co.uk>
   Date: Mon, 5 Nov 2001 14:35:09 +0100
   
   I believe, that it's related to -pre6 David Miller's net updates.

It's Andi Kleen's connect port allocation changes.
If he can't figure out a fix we'll just revert that
stuff.

Franks a lot,
David S. Miller
davem@redhat.com
