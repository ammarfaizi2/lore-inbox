Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284836AbRLPVXi>; Sun, 16 Dec 2001 16:23:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284833AbRLPVXS>; Sun, 16 Dec 2001 16:23:18 -0500
Received: from smtp-out-1.wanadoo.fr ([193.252.19.188]:61387 "EHLO
	mel-rto1.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S284820AbRLPVXO>; Sun, 16 Dec 2001 16:23:14 -0500
Message-ID: <3C1D1032.6090405@wanadoo.fr>
Date: Sun, 16 Dec 2001 22:20:50 +0100
From: Pierre Rousselet <pierre.rousselet@wanadoo.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20011126 Netscape6/6.2.1
X-Accept-Language: fr, en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: 2.5.1-pre11 boot/root
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.5.1-pre11+devfs-patch-v203

2.5.1-pre11 fails mounting the root fs during boot when
the short name of the root device is given to the loader,
for instance :

root=/dev/discs/disc0/part2

it succeeds only with the long name :

root=/dev/ide/host2/bus0/target0/lun0/part2

2.5.1-pre10 was happy with the short name.

It's not a big issue, one just have to know it.

