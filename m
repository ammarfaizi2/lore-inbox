Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132702AbRDCVam>; Tue, 3 Apr 2001 17:30:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132698AbRDCVah>; Tue, 3 Apr 2001 17:30:37 -0400
Received: from slimnet.xs4all.nl ([194.109.194.192]:25349 "EHLO
	gatekeeper.slim") by vger.kernel.org with ESMTP id <S132693AbRDCVaS>;
	Tue, 3 Apr 2001 17:30:18 -0400
Message-ID: <3ACA41D6.83718034@inter.nl.net>
Date: Tue, 03 Apr 2001 23:34:14 +0200
From: Jurgen Kramer <GTM.Kramer@inter.nl.net>
X-Mailer: Mozilla 4.76 [en] (Win95; U)
X-Accept-Language: en
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: 2048 byte/sector problems with kernel 2.4
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I recently acquired a 1.3GB MO drive. When I use small (230MB and 540MB)

MO disks which have normal 512 bytes/sector it all works flawlessly but
as soon
as a put in a 1.3GB disk which uses the 2048 bytes/sector format it all
goes
wrong. As soon as I write something to the disk by issuing a cp command
the command
just eats 99% CPU time and does not write a single byte to disk (it
seems). Is this a
known problem? When I check the kernel logs it seems that the sector
size is correctly
identified. The problems occurs with both the ext2 and fat filesystems.

I also tried it with 2.2.18 there it works but it seems to be utterly
slow. I'm using kernel 2.4.2(XFS version to be precise).

Any solution to this problem?

Greetings,

Jurgen



