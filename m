Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262035AbVDEVMX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262035AbVDEVMX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 17:12:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262040AbVDEVMJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 17:12:09 -0400
Received: from exosec.net1.nerim.net ([62.212.114.195]:42336 "EHLO
	mail-out1.exosec.net") by vger.kernel.org with ESMTP
	id S262035AbVDEVLK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 17:11:10 -0400
Date: Tue, 5 Apr 2005 23:11:00 +0200
From: Willy Tarreau <wtarreau@exosec.fr>
To: linux-kernel@vger.kernel.org
Subject: linux-2.4.29-hf7 (minor update)
Message-ID: <20050405211100.GA28029@exosec.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

just for completeness, I've updated the hotfix tree to hf7. The
changelog is ridiculously small (2 patches: 1 doc, 1 minor). The
2.4.29-hf tree is now up to date with 2.4.30. I will start the
2.4.30-hf soon (when 2.4.31-pre emerges), and will keep updating
2.4.29-hf as long as possible. For this, I'll have to make my
scripts a bit smarter to reduce the dual work, so first 2.4.30-hf
releases might be delayed a bit.

After one full 2.4 release, it seems that the 2.4-hf tree starts
to pay off : one patch which was finally removed in 2.4.30-rc4
never got its way to 2.4-hf and a potential problem affecting
usb-pwc for one 2.4.30 user theorically should not concern
2.4.29-hf. May be those will help maintainers and users of recent
kernels to find where their problem appeared ? Time will tell...

In the mean time, the patches are available at the usual store :

     http://linux.exosec.net/kernel/2.4-hf/


Regards,
Willy

--
Changelog From 2.4.29-hf6 to 2.4.29-hf7 (semi-automated)
---------------------------------------
'+' = added ; '-' = removed


+ bogus-mc_list-deletion-1                                         (Herbert Xu)

  Looks like I made a nasty typo in the 2.4 backport.  When entries
  are unlinked from mc_list, we link the list up with the regular
  hash bucket list by using next instead of bind_next!

+ recent-kernels-need-modutils-2414-1                           (Willy Tarreau)

  From Keith Owens:
  > You need modutils >= 2.4.14 to use the combination of
  > CONFIG_MODVERSIONS with EXPORT_SYMBOL_GPL() on 2.4 kernels.


END.


