Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262525AbVBBNmL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262525AbVBBNmL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 08:42:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262438AbVBBNmK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 08:42:10 -0500
Received: from pat.uio.no ([129.240.130.16]:32750 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S262532AbVBBNmH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 08:42:07 -0500
Date: Wed, 2 Feb 2005 14:31:08 +0100
From: Haakon Riiser <haakon.riiser@fys.uio.no>
To: linux-kernel@vger.kernel.org
Subject: Accelerated frame buffer functions
Message-ID: <20050202133108.GA2410@s>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning
X-UiO-MailScanner: No virus found
X-UiO-Spam-info: not spam, SpamAssassin (score=0.05, required 12,
	autolearn=disabled, FORGED_RCVD_HELO 0.05)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

How can I use a frame buffer driver's optimized copyarea, fillrect,
blit, etc. from userspace?  The only way I've ever seen anyone use
the frame buffer device is by mmap()ing it and doing everything
manually in the mapped memory.  I assume there must be ioctls for
accessing the accelerated functions, but after several hours of
grepping and googling, I give up. :-(

Any help is greatly appreciated!

-- 
 Haakon
