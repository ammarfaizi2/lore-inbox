Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261474AbUKOPaV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261474AbUKOPaV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 10:30:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261623AbUKOPaU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 10:30:20 -0500
Received: from fep03fe.ttnet.net.tr ([212.156.4.134]:60414 "EHLO
	fep03.ttnet.net.tr") by vger.kernel.org with ESMTP id S261474AbUKOPaM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 10:30:12 -0500
Message-ID: <4198CAFC.7030705@ttnet.net.tr>
Date: Mon, 15 Nov 2004 17:27:56 +0200
From: "O.Sezer" <sezeroz@ttnet.net.tr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.3) Gecko/20041003
X-Accept-Language: tr, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: davem@davemloft.net, bunk@stusta.de
Subject: Re: [patch] 2.4.28-rc3: neigh_for_each must be EXPORT_SYMBOL'ed
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A similar export should also be needed for __neigh_for_each_release :

/sbin/depmod -ae -F System.map 2.4.28-rc3aac2
depmod: *** Unresolved symbols in 
/lib/modules/2.4.28-rc3aac2/kernel/net/atm/clip.o
depmod: 	__neigh_for_each_release

Ozkan Sezer

