Return-Path: <linux-kernel-owner+w=401wt.eu-S1750734AbXACNCi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750734AbXACNCi (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 08:02:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750742AbXACNCi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 08:02:38 -0500
Received: from ns9.hostinglmi.net ([213.194.149.146]:60401 "EHLO
	ns9.hostinglmi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750734AbXACNCh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 08:02:37 -0500
X-Greylist: delayed 6212 seconds by postgrey-1.27 at vger.kernel.org; Wed, 03 Jan 2007 08:02:37 EST
Date: Wed, 3 Jan 2007 12:19:36 +0100
From: DervishD <lkml@dervishd.net>
To: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: [KBUILD] I don't want initramfs in 2.6.19.1 but usr/ is still processed
Message-ID: <20070103111936.GB18441@DervishD>
Mail-Followup-To: Linux-kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4.2.2i
Organization: DervishD
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - ns9.hostinglmi.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - dervishd.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi all :)

    I've noticed that, even if I say NO to initramfs (and even ramdisk
support), the make process wants to GEN usr/initramfs_data.cpio.gz by
running the scripts/gen_initramfs_list.sh script.

    Why is that script run no matter the initramfs support? Looks like
it only depends on the contents of CONFIG_INITRAMFS_SOURCE :?

    Thanks in advance :)

    Raúl Núñez de Arenas Coronado

-- 
Linux Registered User 88736 | http://www.dervishd.net
It's my PC and I'll cry if I want to... RAmen!
