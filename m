Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261836AbTABMuk>; Thu, 2 Jan 2003 07:50:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261742AbTABMuk>; Thu, 2 Jan 2003 07:50:40 -0500
Received: from postfix4-1.free.fr ([213.228.0.62]:8380 "EHLO
	postfix4-1.free.fr") by vger.kernel.org with ESMTP
	id <S261836AbTABMuj>; Thu, 2 Jan 2003 07:50:39 -0500
To: linux-kernel@vger.kernel.org
Subject: /proc/partitions statistics: how to find block size?
Message-ID: <1041512348.3e14379c5675c@imp.free.fr>
Date: Thu, 02 Jan 2003 13:59:08 +0100 (CET)
From: jfontain@free.fr
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: IMP/PHP IMAP webmail program 2.2.6
X-Originating-IP: 195.101.92.253
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(please CC me as I am not subscribed: apologies...)

First I wish to thank very much those who wrote the 'Per partition statistics in
/proc/partitions' patch, now available in 2.4.20. It is a very useful feature IMHO.
I am using it to write a new module for the modular monotoring software moodss
(http://jfontain.free.fr/moodss/).

Now, from /proc/partitions, I can find the number of blocks per partition or
disk, but what I also need is the size of each disk, or the block size of each
disk, so that I could display the size in bytes for each disk, which would be
more user friendly.

Is there a way to find that information within the /proc filesystem or by any
other mean (that has to work for any disk type (IDE, SCSI, USB, ...)).

Many thanks in advance and sorry for posting here, but I really need expert
advice...

Happy New Year,

Jean-Luc (jfontain@free.fr)
