Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264015AbRFFSjY>; Wed, 6 Jun 2001 14:39:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264014AbRFFSjO>; Wed, 6 Jun 2001 14:39:14 -0400
Received: from chia.umiacs.umd.edu ([128.8.120.111]:17891 "EHLO
	chia.umiacs.umd.edu") by vger.kernel.org with ESMTP
	id <S263999AbRFFSjI>; Wed, 6 Jun 2001 14:39:08 -0400
Date: Wed, 6 Jun 2001 14:39:05 -0400 (EDT)
From: Adam <adam@cfar.umd.edu>
X-X-Sender: <adam@chia.umiacs.umd.edu>
To: <linux-kernel@vger.kernel.org>
Subject: ethernet and pointopoint
Message-ID: <Pine.GSO.4.33.0106061435060.18152-100000@chia.umiacs.umd.edu>
X-WEB: http://www.eax.com
Content-Type-X: multipart/mixed; boundary="------------3897B7E0F65FF08A89ED6C92"
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


hello,
	Is there reason why I can't set pointopoint for ethernet? I have
	to computers (and two 100mbps ethernet cards) connected via  null-modem
	ethernet cable (with no hub in between).  So since there's no way
	to have more than two hosts talking to each other for all intended
	purposes it IS a pointopoint link.

	looking at net/core/dev.c:dev_change_flags() I see
	that I can't pass IFF_POINTOPOINT to it via ioctl, and
	it will be just sillently dropped, with no error reported
	back to ifconfig.

-- 
Adam
http://www.eax.com	The Supreme Headquarters of the 32 bit registers

