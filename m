Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266082AbRF1SRF>; Thu, 28 Jun 2001 14:17:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266079AbRF1SQ4>; Thu, 28 Jun 2001 14:16:56 -0400
Received: from imo-m06.mx.aol.com ([64.12.136.161]:11465 "EHLO
	imo-m06.mx.aol.com") by vger.kernel.org with ESMTP
	id <S266082AbRF1SQm>; Thu, 28 Jun 2001 14:16:42 -0400
Date: Thu, 28 Jun 2001 14:16:24 -0400
From: hunghochak@netscape.net (Ho Chak Hung)
To: linux-kernel@vger.kernel.org
Subject: Is an outside module supposed to use page cache?
Mime-Version: 1.0
Message-ID: <1EA7E4FA.3574845C.0F76C228@netscape.net>
X-Mailer: Franklin Webmailer 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 
I am trying to develop a module that makes use of the page cache(by allocating a LOT of pages use page_cache_alloc and then add_to_page_cache). However, I got some unresolved symbols error during insmod.(because the symbols related to lru_cache_add.... etc are not exported?) .
I am just wondering if I am not building a file system but at the same time want to allocate a lot of pages of physical memory to store something that has no backup storage as a file, should I add it to the page cache?
Any advice would be greatly appreciated
Thanks 
__________________________________________________________________
Get your own FREE, personal Netscape Webmail account today at http://webmail.netscape.com/
