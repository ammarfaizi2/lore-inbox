Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261562AbUBUO1G (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Feb 2004 09:27:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261561AbUBUO1G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Feb 2004 09:27:06 -0500
Received: from ore.jhcloos.com ([64.240.156.239]:20489 "EHLO ore.jhcloos.com")
	by vger.kernel.org with ESMTP id S261562AbUBUO06 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Feb 2004 09:26:58 -0500
To: linux-kernel@vger.kernel.org
Subject: make help ARCH=xx fun
From: "James H. Cloos Jr." <cloos@jhcloos.com>
Date: Sat, 21 Feb 2004 09:26:41 -0500
Message-ID: <m3y8qwv78e.fsf@lugabout.jhcloos.org>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was looking at the arch-specific make options for various archs,
and found this bit of fun:

:; make help ARCH=sh
[elided]
Architecture specific targets (sh):
  zImage                  - Compressed kernel image (arch/sh/boot/zImage)
  SCCS            - Build for arch/sh/configs/SCCS
  defconfig-adx           - Build for adx
  defconfig-cqreek        - Build for cqreek
  defconfig-dreamcast     - Build for dreamcast
  defconfig-hp680         - Build for hp680
  defconfig-se7751        - Build for se7751
  defconfig-snapgear      - Build for snapgear
  defconfig-systemh       - Build for systemh
[elided]

The defconfig options only show up after a bk get in arch/sh/configs/.

There are also several archs that do not have any arch-specific
help.  ppc64 (unlike ppc) is one such example.

-JimC

