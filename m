Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130111AbQKCAUW>; Thu, 2 Nov 2000 19:20:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130066AbQKCAUM>; Thu, 2 Nov 2000 19:20:12 -0500
Received: from pizda.ninka.net ([216.101.162.242]:39835 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S130137AbQKCAT5>;
	Thu, 2 Nov 2000 19:19:57 -0500
Date: Thu, 2 Nov 2000 16:05:23 -0800
Message-Id: <200011030005.QAA03942@pizda.ninka.net>
From: "David S. Miller" <davem@redhat.com>
To: hpa@transmeta.com
CC: hpa@zytor.com, linux-kernel@vger.kernel.org
In-Reply-To: <3A020319.3384D4FF@transmeta.com> (hpa@transmeta.com)
Subject: Re: select() bug
In-Reply-To: <E13rTfB-00023L-00@the-village.bc.nu> <3A01FC44.8A43FE8B@iname.com> <8tsupp$gh8$1@cesium.transmeta.com> <200011022346.PAA01451@pizda.ninka.net> <3A0200F5.2D6F4F70@transmeta.com> <200011022352.PAA02403@pizda.ninka.net> <3A020319.3384D4FF@transmeta.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   Date: Thu, 02 Nov 2000 16:13:13 -0800
   From: "H. Peter Anvin" <hpa@transmeta.com>

   Oh.  What do you do if there isn't... link up the contents of the
   write() in a kiovec and hold the writer?

Right, the writer blocks.

I've already posted the patches here within the past week, I'll send
them to you under seperate cover so you can see for yourself how it
works.

Later,
David S. Miller
davem@redhat.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
