Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266286AbRGBANK>; Sun, 1 Jul 2001 20:13:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266287AbRGBANA>; Sun, 1 Jul 2001 20:13:00 -0400
Received: from cmailg3.svr.pol.co.uk ([195.92.195.173]:19255 "EHLO
	cmailg3.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S266286AbRGBAMv>; Sun, 1 Jul 2001 20:12:51 -0400
Date: Mon, 2 Jul 2001 01:12:32 +0100
From: Adam Huffman <bloch@verdurin.com>
To: linux-kernel@vger.kernel.org
Subject: Boot problem with 2.4.6-pre8 IDE/HPT370
Message-ID: <20010702011232.A891@bloch.verdurin.priv>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.19i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At the Partition Check stage, I start getting "hde: lost interrupt"
messages.  /dev/hde is an IBM DTLA-307030, sitting on an HPT370
controller (motherboard is KA7-100).  Eventually the partitions appear
in the list, interspersed with these lost interrupt messages, but very
slowly.  Then there was a burst of activity until the "Activating swap
partition" step, at which point the machine stopped responding.  The
swap partition is /dev/hde5.

Just compiled 2.4.5-ac22 for comparison and that works fine.

Adam
