Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276843AbRJHKUm>; Mon, 8 Oct 2001 06:20:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276841AbRJHKUd>; Mon, 8 Oct 2001 06:20:33 -0400
Received: from mailout03.sul.t-online.com ([194.25.134.81]:18068 "EHLO
	mailout03.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S276843AbRJHKUP>; Mon, 8 Oct 2001 06:20:15 -0400
Date: Sun, 7 Oct 2001 20:35:40 +0200
From: kladit@t-online.de (Klaus Dittrich)
To: linux mailing-list <linux-kernel@vger.kernel.org>
Subject: 2.4.11.p4 and dd
Message-ID: <20011007203540.A392@df1tlpc.local.here>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

dd does not work anymore.

dd if=/dev/sda of=/dev/sdb bs=1024k 

stops with "File size limit exceeded"

Using kernel 2.4.3 the same command works fine.

2.4.3 uses a large amount of buffer, 2.4.11p4 only chache.
2.4.3 doesn't swap, 2.4.11p4 eats up 1 GB RAM and 100 MB swap.

-- 
Best regards 
Klaus Dittrich

e-mail: kladit@t-online.de
