Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129480AbQKCABm>; Thu, 2 Nov 2000 19:01:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129313AbQKCABc>; Thu, 2 Nov 2000 19:01:32 -0500
Received: from pizda.ninka.net ([216.101.162.242]:26779 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S129363AbQKCABO>;
	Thu, 2 Nov 2000 19:01:14 -0500
Date: Thu, 2 Nov 2000 15:46:35 -0800
Message-Id: <200011022346.PAA01451@pizda.ninka.net>
From: "David S. Miller" <davem@redhat.com>
To: hpa@zytor.com
CC: linux-kernel@vger.kernel.org
In-Reply-To: <8tsupp$gh8$1@cesium.transmeta.com> (hpa@zytor.com)
Subject: Re: select() bug
In-Reply-To: <E13rTfB-00023L-00@the-village.bc.nu> <3A01FC44.8A43FE8B@iname.com> <8tsupp$gh8$1@cesium.transmeta.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: "H. Peter Anvin" <hpa@zytor.com>
   Date: 	2 Nov 2000 15:53:29 -0800

   Has anyone considered the possibility of expanding the buffer of
   high-traffic pipes?

The kiobuf pipe patches are a more effective performance improvement
for this type of usage.  It has the benefit of not requiring a
temporary kernel buffer of any size :-)

Later,
David S. Miller
davem@redhat.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
