Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284133AbRLKVq6>; Tue, 11 Dec 2001 16:46:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284118AbRLKVqi>; Tue, 11 Dec 2001 16:46:38 -0500
Received: from echo.sound.net ([205.242.192.21]:35300 "HELO echo.sound.net")
	by vger.kernel.org with SMTP id <S284088AbRLKVqa>;
	Tue, 11 Dec 2001 16:46:30 -0500
Date: Tue, 11 Dec 2001 15:40:16 -0600 (CST)
From: Hal Duston <hald@sound.net>
To: linux-kernel@vger.kernel.org
Subject: bio and "old" block drivers
Message-ID: <Pine.GSO.4.10.10112111539180.5913-100000@sound.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm looking at the bio changes for ps2esdi.  The driver
appears to no longer work compiled when into the kernel.
The ps2esdi_init call has been removed from
ll_rw_blk.c:blk_dev_init.  Where is the new/correct place
to call this from?  This appears to be the same way with
many of the other "old" block drivers as well.

Thanks, and not on the list,
Hal Duston
hald@sound.net

