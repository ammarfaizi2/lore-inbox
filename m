Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264229AbRFFWwx>; Wed, 6 Jun 2001 18:52:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264225AbRFFWwn>; Wed, 6 Jun 2001 18:52:43 -0400
Received: from pizda.ninka.net ([216.101.162.242]:24203 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S261763AbRFFWwf>;
	Wed, 6 Jun 2001 18:52:35 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15134.46127.655134.233625@pizda.ninka.net>
Date: Wed, 6 Jun 2001 15:52:31 -0700 (PDT)
To: Alexander Viro <viro@math.psu.edu>
Cc: "La Monte H.P. Yarroll" <piggy@em.cig.mot.com>,
        "Matt D. Robinson" <yakker@alacritech.com>,
        linux-kernel@vger.kernel.org, sctp-developers-list@cig.mot.com
Subject: Re: [PATCH] sockreg2.4.5-05 inet[6]_create() register/unregister
 table
In-Reply-To: <Pine.GSO.4.21.0106061832220.10233-100000@weyl.math.psu.edu>
In-Reply-To: <15134.43914.98253.998655@pizda.ninka.net>
	<Pine.GSO.4.21.0106061832220.10233-100000@weyl.math.psu.edu>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Alexander Viro writes:
 > 	Erm... What stops those who want to do such implementations
 > from using AF_PACKET and handling the whole thing in userland?

Nothing stops them, except the fact that this would be inefficient as
hell.  Streams would be quicker :-)

Later,
David S. Miller
davem@redhat.com
