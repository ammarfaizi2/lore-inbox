Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131936AbRAJJOZ>; Wed, 10 Jan 2001 04:14:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133014AbRAJJOP>; Wed, 10 Jan 2001 04:14:15 -0500
Received: from gw1-mi1-as3.esiway.net ([193.194.16.163]:20743 "EHLO
	fuoco.tieffe.intranet") by vger.kernel.org with ESMTP
	id <S131936AbRAJJOJ>; Wed, 10 Jan 2001 04:14:09 -0500
Date: Wed, 10 Jan 2001 10:18:24 +0100
From: Gabriele Turchi <turchi@tieffesistemi.com>
To: linux-kernel@vger.kernel.org
Subject: Re: NFS root doesn't work with 2.2.18.
Message-ID: <20010110101824.A9912@tieffesistemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Some time ago I've done some tests with IP autoconfiguration. When
switched to 2.2.18 kernel I've found a changed behaviour: apparently
the new default is not to boot by network automatically, but to expect
a kernel command-line parameter (like ip=dhcp I think). I've solved
the problem in a more "brutal" way modifying the source
(net/ipv4/ipconfig.c, if I remember correctly).

Hope this helps.

Best wishes,

	Gabriele Turchi


P.S.: I'm sorry, my english is in alpha version...

-- 
----------------------------------------------------------------------------
 Gabriele Turchi (Responsabile Tecnico)            turchi@tieffesistemi.com
 Tieffe Sistemi S.r.l.                                www.tieffesistemi.com
 V.le Piceno 21 - 20129 Milano - Italia             tel/fax +39 02 76115215
----------------------------------------------------------------------------

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
