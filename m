Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129516AbQLAHSl>; Fri, 1 Dec 2000 02:18:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130177AbQLAHSb>; Fri, 1 Dec 2000 02:18:31 -0500
Received: from ja.ssi.bg ([193.68.177.189]:6404 "EHLO u.domain.uli")
	by vger.kernel.org with ESMTP id <S129516AbQLAHST>;
	Fri, 1 Dec 2000 02:18:19 -0500
Date: Fri, 1 Dec 2000 08:47:28 +0000 (GMT)
From: Julian Anastasov <ja@ssi.bg>
To: Scott Bisker <scott@e247inc.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Arping loopback question.
Message-ID: <Pine.LNX.4.21.0012010840400.950-100000@u>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	Hello,

On Thu, 30 Nov 2000, Scott Bisker wrote:

> noarp, and I've set /proc/sys/net/ipv4/conf/lo/hidden to 1.  The

	You need to change the all/ section too:

	echo 1 > /proc/sys/net/ipv4/conf/all/hidden

Regards

--
Julian Anastasov <ja@ssi.bg>

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
