Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132633AbRDXAsN>; Mon, 23 Apr 2001 20:48:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132625AbRDXAsD>; Mon, 23 Apr 2001 20:48:03 -0400
Received: from pizda.ninka.net ([216.101.162.242]:25473 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S132633AbRDXArv>;
	Mon, 23 Apr 2001 20:47:51 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15076.52523.986318.575378@pizda.ninka.net>
Date: Mon, 23 Apr 2001 17:47:39 -0700 (PDT)
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.3ac13
In-Reply-To: <E14rqT9-0000s4-00@the-village.bc.nu>
In-Reply-To: <E14rqT9-0000s4-00@the-village.bc.nu>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Alan Cox writes:
 > 2.4.3-ac13
 > o	Switch to NOVERS symbols for rwsem		(me)
 > 	| Called from asm blocks so they can't be versioned

Yes they most certainly can be versioned inside of an asm.  Use the
"i" constraint, we've been doing this on sparc64 for ages.

Later,
David S. Miller
davem@redhat.com
