Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130132AbRAZLd7>; Fri, 26 Jan 2001 06:33:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131090AbRAZLds>; Fri, 26 Jan 2001 06:33:48 -0500
Received: from pizda.ninka.net ([216.101.162.242]:40080 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S130132AbRAZLdd>;
	Fri, 26 Jan 2001 06:33:33 -0500
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14961.24658.319734.448248@pizda.ninka.net>
Date: Fri, 26 Jan 2001 03:32:34 -0800 (PST)
To: Matti Aarnio <matti.aarnio@zmailer.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: hotmail not dealing with ECN
In-Reply-To: <20010126123749.E25659@mea-ext.zmailer.org>
In-Reply-To: <Pine.LNX.4.21.0101250041440.1498-100000@srv2.ecropolis.com>
	<94qcvm$9qp$1@cesium.transmeta.com>
	<14960.54069.369317.517425@pizda.ninka.net>
	<20010126123749.E25659@mea-ext.zmailer.org>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Matti Aarnio writes:
 >   But could you nevertheless consider supplying a socket option for it ?
 >   By all means default it per sysctl, but allow clearing/setting by
 >   program too.

No, because then people will do the wrong thing.

They will create intricate "ECN black lists" and make
their apps set the socket option based upon whether
a site is in the black list or not.

This is wrong, and allows the problematic sites to continue to be
delinquent.

If these sites gradually become more and more disconnected from
the rest of the internet, they will fix their kit.  Other schemes
so far have been met with reluctance on the part of these sites.

I do not want to condone mechanisms which allow people to make
crutches for these broken sites ad infinitum.

Later,
David S. Miller
davem@redhat.com

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
