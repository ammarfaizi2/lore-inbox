Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261188AbUCHUdU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 15:33:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261190AbUCHUdU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 15:33:20 -0500
Received: from main.gmane.org ([80.91.224.249]:13220 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261188AbUCHUdP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 15:33:15 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: =?ISO-8859-15?Q?Sven_K=F6hler?= <skoehler@upb.de>
Subject: IOMMU/AGP troubles on AMD64
Date: Mon, 08 Mar 2004 21:31:45 +0100
Message-ID: <c2ila7$jp6$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: p508a591e.dip.t-dialin.net
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: de, en
X-Enigmail-Version: 0.83.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

i've bought a new Motherboard: Asrock K8S8X (SiS 755 based)

It's running pretty fine, but i can only use 448MB of my 512MB memory.
So here's why:

   Checking aperture...
   CPU 0: aperture @ e0000000 size 32 MB
   Aperture from northbridge cpu 0 too small (32 MB)
   AGP bridge at 00:00:00
   Aperture from AGP @ e0000000 size 32 MB (APSIZE 38)
   Aperture from AGP bridge too small (32 MB)
   Your BIOS doesn't leave a aperture memory hole
   Please enable the IOMMU option in the BIOS setup
   This costs you 64 MB of RAM
   Mapping aperture over 65536 KB of RAM @ 4000000

This is what the kernel tells me when booting.
I already mailed to Asrock that this might be an issue with their BIOS, 
but the answer was very "untechnical":

   We did not test Linux.
   If you need Linux driver, please check from SiS Web Site.
   www.sis.com.tw

The problem is, that i don't know enought to decide, if this is an issue 
than can be fixed in the Linux-Kernel or if this problem should/must be 
fixed in the BIOS. There is no IOMMU-Option in the BIOS.

Thx
   Sven

