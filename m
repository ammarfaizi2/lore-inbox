Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131480AbRCWWdg>; Fri, 23 Mar 2001 17:33:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131489AbRCWWdT>; Fri, 23 Mar 2001 17:33:19 -0500
Received: from pizda.ninka.net ([216.101.162.242]:45710 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S131480AbRCWWcv>;
	Fri, 23 Mar 2001 17:32:51 -0500
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15035.52928.752970.499581@pizda.ninka.net>
Date: Fri, 23 Mar 2001 14:31:28 -0800 (PST)
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: torvalds@transmeta.com (Linus Torvalds),
        sct@redhat.com (Stephen C. Tweedie), linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, bcrl@redhat.com (Ben LaHaise),
        cr@sap.com (Christoph Rohland)
Subject: Re: [PATCH] Fix races in 2.4.2-ac22 SysV shared memory
In-Reply-To: <E14gZuj-0005YN-00@the-village.bc.nu>
In-Reply-To: <Pine.LNX.4.31.0103231157200.766-100000@penguin.transmeta.com>
	<E14gZuj-0005YN-00@the-village.bc.nu>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Alan Cox writes:
 > Umm find_lock_page doesnt sleep does it ?

It does lock_page, which sleeps to get the lock if necessary.

Later,
David S. Miller
davem@redhat.com
