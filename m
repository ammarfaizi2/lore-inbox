Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268429AbUHTRpH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268429AbUHTRpH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 13:45:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268448AbUHTRpH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 13:45:07 -0400
Received: from mxfep02.bredband.com ([195.54.107.73]:9433 "EHLO
	mxfep02.bredband.com") by vger.kernel.org with ESMTP
	id S268429AbUHTRpE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 13:45:04 -0400
Subject: 2.6.8.1-mm, programs crashing on x86_64
From: Alexander Nyberg <alexn@telia.com>
To: linux-kernel@vger.kernel.org
Cc: ak@suse.de
Content-Type: text/plain
Message-Id: <1093023902.908.8.camel@boxen>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 20 Aug 2004 19:45:02 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This does not happen in linus -bk. I noticed it happens in
2.6.8-mm2 also, but not sure about earlier. I'll try some earlier
-mm's and if noone knows what could be it I'll do a binary search.

Must be quite newly introduced though...

boxen:~# chroot /mnt/store/x86/ bash
bash[911] bad frame in 32bit signal deliver frame:00000000ffffd220 rip:556605d6 rsp:ffffd500 orax:ffffffffffffffff
bash[910] bad frame in 32bit signal deliver frame:00000000ffffd220 rip:556605d6 rsp:ffffd500 orax:ffffffffffffffff
bash[910]: segfault at 00000000ffffd51c rip 00000000556605d6 rsp 00000000ffffd500 error 7
bash[911]: segfault at 00000000ffffd51c rip 00000000556605d6 rsp 00000000ffffd500 error 7




