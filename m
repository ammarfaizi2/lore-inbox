Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265530AbRFVVqE>; Fri, 22 Jun 2001 17:46:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265531AbRFVVpy>; Fri, 22 Jun 2001 17:45:54 -0400
Received: from imo-m07.mx.aol.com ([64.12.136.162]:7138 "EHLO
	imo-m07.mx.aol.com") by vger.kernel.org with ESMTP
	id <S265530AbRFVVph>; Fri, 22 Jun 2001 17:45:37 -0400
Date: Fri, 22 Jun 2001 17:45:27 -0400
From: hunghochak@netscape.net (Ho Chak Hung)
To: linux-kernel@vger.kernel.org
Subject: How does ramfs actually fills the page cache with data?
Mime-Version: 1.0
Message-ID: <65E4C5C3.33174328.0F76C228@netscape.net>
X-Mailer: Franklin Webmailer 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In fs/ramfs/inode.c, how does ramfs actually fills the page cache with data? In the readpage operation, it only zero-fill the page if it didn't already exist in the page cache. However, how do I actually fill the page with data?

Thanks a lot.


__________________________________________________________________
Get your own FREE, personal Netscape Webmail account today at http://webmail.netscape.com/
