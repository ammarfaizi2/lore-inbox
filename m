Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265322AbRFVDdr>; Thu, 21 Jun 2001 23:33:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265323AbRFVDdi>; Thu, 21 Jun 2001 23:33:38 -0400
Received: from imo-m10.mx.aol.com ([64.12.136.165]:47556 "EHLO
	imo-m10.mx.aol.com") by vger.kernel.org with ESMTP
	id <S265322AbRFVDdZ>; Thu, 21 Jun 2001 23:33:25 -0400
Date: Thu, 21 Jun 2001 23:33:11 -0400
From: hunghochak@netscape.net (Ho Chak Hung)
To: linux-kernel@vger.kernel.org
Subject: Using page cache without a file system 
Mime-Version: 1.0
Message-ID: <72AE45C3.2DE2C328.0F76C228@netscape.net>
X-Mailer: Franklin Webmailer 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Is it possible to allocate and add pages to the page cache without a underlying file system in Linux 2.4? I know that the host pointer to inode structure inside the address_space structure can be NULL, but does this mean that we can still make use of page cache operations like readpage or writepage if we do not back up the cache with a file system? I am currently developing a driver that wants to make use of the page cache, however, I want to save myself with the heavy load of kmalloc.

Any hint would be greatly appreciated.

Thanks
__________________________________________________________________
Get your own FREE, personal Netscape Webmail account today at http://webmail.netscape.com/
