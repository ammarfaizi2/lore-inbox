Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262990AbUDEHdO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 03:33:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262238AbUDEHdN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 03:33:13 -0400
Received: from alpha.logic.tuwien.ac.at ([128.130.175.20]:39949 "EHLO
	alpha.logic.tuwien.ac.at") by vger.kernel.org with ESMTP
	id S262990AbUDEHdJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 03:33:09 -0400
Date: Mon, 5 Apr 2004 09:11:58 +0200
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       pilot-link-devel@pilot-link.org
Subject: pilot USB HotSync broken in -mm kernels
Message-ID: <20040405071158.GA20124@gamma.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.28i
From: Norbert Preining <preining@logic.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew, hil lists!

USB HotSyncing is not working ATM with -mm kernels: I tried 2.6.5
(vanilla) and had no problem installing a big file with pilot-xfer -I,
but using 2.6.5-mm1 the palm suddenly tells me
	Cleaning up
and then
	The connection was terminated ... not all files synced ...

I have tested several mm Versions (2.6.5-rc?-mm?), none of them were
working, but the vanilla kernel 2.6.5 and 2.6.4 are working.

The diffs in the .config files wrt USB (for 2.6.5(-mm1)):
+CONFIG_USB_EHCI_ROOT_HUB_TT=y

But since this options was only introduced in 2.6.5-mm1 (or was it
rc3-mm4?) this cannot make the difference.

Thanks a lot for any ideas/hints how to fix this.

BTW: debian/sid 

Best wishes

Norbert

-------------------------------------------------------------------------------
Norbert Preining <preining AT logic DOT at>         Technische Universität Wien
gpg DSA: 0x09C5B094      fp: 14DF 2E6C 0307 BE6D AD76  A9C0 D2BF 4AA3 09C5 B094
-------------------------------------------------------------------------------
His eyes seemed to be popping out of his head. He wasn't
certain if this was because they were trying to see more
clearly, or if they simply wanted to leave at this point.
                 --- Arthur trying to see who had diverted him from going to
                 --- a party.
                 --- Douglas Adams, The Hitchhikers Guide to the Galaxy
