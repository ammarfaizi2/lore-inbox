Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268021AbUHVQv3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268021AbUHVQv3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Aug 2004 12:51:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268022AbUHVQv3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Aug 2004 12:51:29 -0400
Received: from imap.infonegocio.com ([213.4.129.150]:58544 "EHLO
	telesmtp4.mail.isp") by vger.kernel.org with ESMTP id S268021AbUHVQv2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Aug 2004 12:51:28 -0400
From: Unai Garro <ugarro@telefonica.net>
To: linux-kernel@vger.kernel.org
Subject: RTL-8139 Network card slow down on 2.6.8.1-mm
Date: Sun, 22 Aug 2004 18:50:34 +0200
User-Agent: KMail/1.6.82
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200408221850.34538.ugarro@telefonica.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, it seems the last mm patches for 2.6.8.1 have caused my network card 
(Realtek 8139)  to go buggy. 

When downloading big files (say ftp.kernel.org last kernel) the card will 
begin downloading at fullspeed of my adsl line, but it will start slowing 
down the speed, down to zero.

I can't see this effect on the vanilla 2.6.8.1 kernel, but it seems to happen 
on both -mm3 & -mm4 that I tested. I'm not using any traffic shaping and I 
even tried to disable quite a few network features trying to solve it with no 
good results.

I wish I could provide more info than this, but dmesg doesn't seem to show any 
problems, and I really don't know how to provide more useful data on this. 
Please let me know if I can help with debugging this or providing more data 
somehow

 Unai

PS: Sorry for writing to this list being it -mm specific, but the linux-mm 
list address that I have doesn't seem to work anymore
