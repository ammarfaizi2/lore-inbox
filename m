Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262357AbTIEIKh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 04:10:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262368AbTIEIKg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 04:10:36 -0400
Received: from sinma-gmbh.17.mind.de ([212.21.92.17]:56843 "EHLO gw.enyo.de")
	by vger.kernel.org with ESMTP id S262357AbTIEIKf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 04:10:35 -0400
To: hps@intermeta.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: bandwidth for bkbits.net (good news)
References: <20030830230701.GA25845@work.bitmover.com>
	<87llt9bvtc.fsf@deneb.enyo.de> <bj1fhj$its$4@tangens.hometree.net>
From: Florian Weimer <fw@deneb.enyo.de>
Mail-Followup-To: hps@intermeta.de, linux-kernel@vger.kernel.org
Date: Fri, 05 Sep 2003 10:10:31 +0200
In-Reply-To: <bj1fhj$its$4@tangens.hometree.net> (Henning P.
 Schmiedehausen's message of "Tue, 2 Sep 2003 07:06:27 +0000 (UTC)")
Message-ID: <874qzrsljc.fsf@deneb.enyo.de>
User-Agent: Gnus/5.1003 (Gnus v5.10.3) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Henning P. Schmiedehausen" <hps@intermeta.de> writes:

> Florian Weimer <fw@deneb.enyo.de> writes:
>
>>do this for a T1 customer (typically, it requires "unusual"
>>configuration of vital production routers with the fat pipes).
>
> You need a shaper connected to the ISP backbone which shapes the
> outgoing traffic for you and a border router which talks to the T1
> (C17xx or C26xx). Normally, if your ISP has some sort of clue, you
> will also need a bastion router which can handle backbone <-> 100 MBit
> traffic and does dynamic routing updates (EGP or OSPF) to the ISP
> backbone (A C26xx or C37xx).

C37xx can handle a maximum load of 225 kpps (data sheet number,
i.e. this value cannot be exceeded even under most favorable
conditions), the others handle even less.  Such routers are of no help
during a DoS attack.

Yes, I snipped the DoS context, and your approach would work in a
benign environment. 8-)
