Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261159AbUFJMZV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261159AbUFJMZV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jun 2004 08:25:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261179AbUFJMZV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jun 2004 08:25:21 -0400
Received: from sasami.anime.net ([207.109.251.120]:52951 "EHLO
	sasami.anime.net") by vger.kernel.org with ESMTP id S261159AbUFJMZS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jun 2004 08:25:18 -0400
X-Antispam-Origin-Id: c4dc35da7d5d290438c6d6bdb17308d1
Date: Thu, 10 Jun 2004 05:25:17 -0700 (PDT)
From: Dan Hollis <goemon@anime.net>
To: linux-kernel@vger.kernel.org
Subject: random fs corruption with iriver ihp-120, usb2, vfat and 2.6.5
Message-ID: <Pine.LNX.4.44.0406100516440.31443-100000@sasami.anime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Greylist: Message not sent from an IPv4 address, not delayed by milter-greylist-1.3.8 (sasami.anime.net [0.0.0.0]); Thu, 10 Jun 2004 05:25:17 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Reply in email please, i'm not subscribed to l-k.

I guess I'm seeing the same corruption as reported in this thread:
http://www.mail-archive.com/linux-usb-users@lists.sourceforge.net/msg10327.html

If I copy large files to this device and then read it back, I always 
get different md5sums. And random filesystem corruption.

I've learned that the drive in this device, a Toshiba MK2004GAL is 
connected directly to the usb2.0 via a cypress CY7C68310:
http://www.cypress.com/products/datasheet.cfm?partnum=CY7C68310

Anyone have a patch I can try to address the errors?

-Dan

