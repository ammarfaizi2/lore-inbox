Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262859AbVCDBne@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262859AbVCDBne (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 20:43:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262829AbVCDBjE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 20:39:04 -0500
Received: from hs-grafik.net ([80.237.205.72]:15500 "EHLO
	ds80-237-205-72.dedicated.hosteurope.de") by vger.kernel.org
	with ESMTP id S262687AbVCDBfa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 20:35:30 -0500
From: Alexander Gran <alex@zodiac.dnsalias.org>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-rc5-mm1: reiser4 panic
Date: Fri, 4 Mar 2005 02:35:25 +0100
User-Agent: KMail/1.7.2
References: <200503040216.56889@zodiac.zodiac.dnsalias.org>
In-Reply-To: <200503040216.56889@zodiac.zodiac.dnsalias.org>
X-Need-Girlfriend: always
X-Ignorant-User: yes
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200503040235.25609@zodiac.zodiac.dnsalias.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 4. März 2005 02:16 schrieb Alexander Gran:
> Hi,
>
> after my external USB hdd disconnected itself reiser4 paniced. I dont think
> a journalingfs should panic if its device fails..

Ähm correction: It's reiser4 on dm-crypto (aes) The crypto device is of cource 
not radable either: Buffer I/O error on device dm-0, logical block 7
scsi2 (0:0): rejecting I/O to dead device
Strangely enough, there were no "Buffer I/O error on device dm-0, logical 
block 7" mesages in demsg before reiser4 paniced

Alex
-- 
Encrypted Mails welcome.
PGP-Key at http://zodiac.dnsalias.org/misc/pgpkey.asc | Key-ID: 0x6D7DD291
