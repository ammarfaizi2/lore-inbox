Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273872AbRIXLYo>; Mon, 24 Sep 2001 07:24:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273870AbRIXLYe>; Mon, 24 Sep 2001 07:24:34 -0400
Received: from [195.246.135.25] ([195.246.135.25]:5639 "EHLO
	chert.194.133.98.200") by vger.kernel.org with ESMTP
	id <S273867AbRIXLYY>; Mon, 24 Sep 2001 07:24:24 -0400
Date: Mon, 24 Sep 2001 15:23:56 +0200
From: Andrei Lahun <Uman@editec-lotteries.com>
To: linux-kernel@vger.kernel.org
Subject: process stopped in D state for seconds
Message-ID: <20010924152356.A14097@chert.194.133.98.200>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

with kernel 2.4.10p12-p15 i found that with dvdplayer (xine)
when i make search in movie one of the thread is stopped in D state for seconds
(2-10 seconds) after it continue to work.
with 2.4.10p10(probably also p11) everything is good.
strace gave me ioctl(0x13,0x5392) so i found that itis in DVD_DO_AUTH
(in case of DVD_LU_SEND_ASF) so itis call to ide_cdrom_packet.
Any ideas?
Andrei
