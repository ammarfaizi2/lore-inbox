Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314096AbSE2RXI>; Wed, 29 May 2002 13:23:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314085AbSE2RXH>; Wed, 29 May 2002 13:23:07 -0400
Received: from imo-m09.mx.aol.com ([64.12.136.164]:46791 "EHLO
	imo-m09.mx.aol.com") by vger.kernel.org with ESMTP
	id <S314083AbSE2RXH>; Wed, 29 May 2002 13:23:07 -0400
Date: Wed, 29 May 2002 13:18:33 -0400
From: gndutm@netscape.net
To: linux-kernel@vger.kernel.org
Subject: can't include headers
Message-ID: <5A753748.173116C9.000634D3@netscape.net>
X-Mailer: Atlas Mailer 2.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,
I need to write a device driver under linux. I am using slackware linux  kernel 2.4.18. 
I have problem to include headers, here is some of my code:

#define __KERNEL__
#include <linux/config.h>      (ok) 

#ifdef CONFIG_MODVERSIONS
#define MODVERSIONS
#include <linux/modversions.h> (ok)
#endif

#include <linux/module.h>      (ok)
#include <linux/stddef.h>      (ok) 
#include <linux/kernel.h>      (ok)               
#include <linux/mm.h>          <--- can't include this one
 
Any comments is greatly appreciated.
Thanks alot.

Ganda



__________________________________________________________________
Your favorite stores, helpful shopping tools and great gift ideas. Experience the convenience of buying online with Shop@Netscape! http://shopnow.netscape.com/

Get your own FREE, personal Netscape Mail account today at http://webmail.netscape.com/

