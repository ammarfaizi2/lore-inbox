Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314277AbSFTM6x>; Thu, 20 Jun 2002 08:58:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314278AbSFTM6w>; Thu, 20 Jun 2002 08:58:52 -0400
Received: from internal-bristol34.naxs.com ([216.98.66.34]:27269 "EHLO
	coredump.electro-mechanical.com") by vger.kernel.org with ESMTP
	id <S314277AbSFTM6v>; Thu, 20 Jun 2002 08:58:51 -0400
Date: Thu, 20 Jun 2002 08:52:08 -0400
From: William Thompson <wt@electro-mechanical.com>
To: linux-kernel@vger.kernel.org
Subject: Problem with raid0 with 2.4.19-pre10-ac2
Message-ID: <20020620085208.A7666@coredump.electro-mechanical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I create a 2 disk raid 0.  I stop it and attempt to start it again and it
doesn't start.  It apparently doesn't write out the persistant super block. 
I did not reboot when i did this.  I don't have a transcript of what
happened.  I can get it later if it's needed.

Who writes the superblock anyway?  mkraid or the kernel driver?
