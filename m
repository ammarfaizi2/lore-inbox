Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271972AbRH2OGq>; Wed, 29 Aug 2001 10:06:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271974AbRH2OGh>; Wed, 29 Aug 2001 10:06:37 -0400
Received: from mustard.heime.net ([194.234.65.222]:49024 "EHLO
	mustard.heime.net") by vger.kernel.org with ESMTP
	id <S271972AbRH2OGT>; Wed, 29 Aug 2001 10:06:19 -0400
Date: Wed, 29 Aug 2001 16:06:35 +0200 (CEST)
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
To: <linux-kernel@vger.kernel.org>
Subject: Error accessing loop-back mounted file systems via nfs
Message-ID: <Pine.LNX.4.30.0108291604070.4183-100000@mustard.heime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi all

I did this lately:

# dd if=/dev/cdrom of=cd1.iso
# mount -o loop -o ro cd1.iso /iso/cd1

added the /iso dir in /etc/exports and restarted nfs.

When accessing this dir from an nfs client, I can see anything except
what's from the loopback mounted system.

Please cc: to me as I'm not on the list.

roy

