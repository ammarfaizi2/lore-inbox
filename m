Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262279AbUDKIFY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Apr 2004 04:05:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262291AbUDKIFX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Apr 2004 04:05:23 -0400
Received: from waste.org ([209.173.204.2]:39846 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S262279AbUDKIFQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Apr 2004 04:05:16 -0400
Date: Sun, 11 Apr 2004 03:05:15 -0500
From: Matt Mackall <mpm@selenic.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [ANNOUNCE] ketchup 0.5 (formerly kpatchup)
Message-ID: <20040411080515.GX6248@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ketchup is a script that automatically patches between kernel
versions, downloading and caching patches as needed, and automatically
determining the latest versions of several trees. Example usage:

 $ ketchup 2.6-mm
 2.6.3-rc1-mm1 -> 2.6.5-mm4
 Applying 2.6.3-rc1-mm1.bz2 -R
 Applying patch-2.6.3-rc1.bz2 -R
 Applying patch-2.6.3.bz2
 Applying patch-2.6.4.bz2
 Applying patch-2.6.5.bz2
 Downloading 2.6.5-mm4.bz2
 Downloading 2.6.5-mm4.bz2.sign
 Verifying signature...
 gpg: Signature made Sat Apr 10 21:55:36 2004 CDT using DSA key ID 517D0F0E
 gpg: Good signature from "Linux Kernel Archives Verification Key
 <ftpadmin@kernel.org>"
 gpg:                 aka "Linux Kernel Archives Verification Key
 <ftpadmin@kernel.org>"
 owner.
 gpg: WARNING: This key is not certified with a trusted signature!
 gpg:          There is no indication that the signature belongs to the
 Primary key fingerprint: C75D C40A 11D7 AF88 9981  ED5B C86B A06A 517D 0F0E
 Applying 2.6.5-mm4.bz2


New in this version by popular demand:

- name change kpatchup -> ketchup
- automatic signature verification
- works with older versions of Python

Currently it defaults to trying to use gpg, which means you must have
gpg installed and the appropriate keys in your keyring. You can
disable this with the -g or --no-gpg options.

Available at:

http://selenic.com/ketchup/ketchup-0.5

-- 
Matt Mackall : http://www.selenic.com : Linux development and consulting
