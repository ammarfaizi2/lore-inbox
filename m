Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274174AbRJILJN>; Tue, 9 Oct 2001 07:09:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274964AbRJILJD>; Tue, 9 Oct 2001 07:09:03 -0400
Received: from mailout01.sul.t-online.com ([194.25.134.80]:19332 "EHLO
	mailout01.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S274174AbRJILIt>; Tue, 9 Oct 2001 07:08:49 -0400
Date: Tue, 9 Oct 2001 13:06:56 +0200
From: kladit@t-online.de (Klaus Dittrich)
To: linux mailing-list <linux-kernel@vger.kernel.org>
Subject: 2.4.11-pre6 
Message-ID: <20011009130544.A737@df1tlpc.local.here>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


dd and mkfs works with 2.4.3 but not with 2.4.11.x or 2.4.10.x
 
dd if=/dev/sda of=/dev/sdb bs=1024k   or   mkfs /dev/sdb3 
both fail with "File size limit exceeded"

Booting the same system with 2.4.3 or 2.2.19 anything
works as expected.

So is the problem with the kernel (as I assume) or do I miss something ?

Can anyone else please verify this ? 

(One really needs two disks, dd if=/dev/sda of=/dev/null does not show
the problem)

-- 
Best regards
Klaus Dittrich

e-mail: kladit@t-online.de
