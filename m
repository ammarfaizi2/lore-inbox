Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271764AbRICSfa>; Mon, 3 Sep 2001 14:35:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271765AbRICSfT>; Mon, 3 Sep 2001 14:35:19 -0400
Received: from hera.cwi.nl ([192.16.191.8]:49808 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S271764AbRICSfJ>;
	Mon, 3 Sep 2001 14:35:09 -0400
From: Andries.Brouwer@cwi.nl
Date: Mon, 3 Sep 2001 18:35:25 GMT
Message-Id: <200109031835.SAA33971@vlet.cwi.nl>
To: hch@caldera.de, torvalds@transmeta.com
Subject: Re: [PATCH] cleanup gendisk handling
Cc: Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    From hch@ns.caldera.de Mon Sep  3 20:06:04 2001

    Hi Linus,

    as you probably know the gendisk handling in the current kernel is a
    horrible mess.  All driver have to do the linked list handling themselves,
    etc..

    Andries has a patchset on kernel.org that addresses most of this issues -
    but it does very large API changes and is thus not acceptable for 2.4.

    The appended patch tries to cleanup the gendisk handling for the in-kernel
    driver a LOT, keeping all old APIs for posssible out-of-tree drivers.

Hmm - this looks almost identical to my patch 07.
Yes, a nice patch :-)

Andries


[BTW - I don't think the API changes are so large.
Now patch 01 has been applied.
Something very similar to 02 seems also a good candidate.
Maybe I have time Friday or Saturday to rediff.]


