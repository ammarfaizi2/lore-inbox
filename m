Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262985AbTEHCoo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 22:44:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263001AbTEHCoo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 22:44:44 -0400
Received: from fmr01.intel.com ([192.55.52.18]:39908 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id S262985AbTEHCon convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 22:44:43 -0400
Message-ID: <A46BBDB345A7D5118EC90002A5072C780C8FE1DC@orsmsx116.jf.intel.com>
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: "'Christoph Hellwig'" <hch@lst.de>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] make <linux/blk.h> obsolete
Date: Wed, 7 May 2003 19:57:16 -0700 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> From: Christoph Hellwig [mailto:hch@lst.de]
> 
> --- 1.35/include/linux/blk.h	Sun Apr 20 19:22:00 2003
> +++ edited/include/linux/blk.h	Thu May  1 17:20:09 2003
> @@ -1,41 +1,2 @@
> -#ifndef _BLK_H
> -#define _BLK_H
> -
> +/* this file is obsolete, please use <linux/blkdev.h> instead */

#warning this file is obsolete, please use <linux/blkdev.h> instead

At least is kind of more noisy and easy to spot when compiling ...

Iñaky Pérez-González -- Not speaking for Intel -- all opinions are my own
(and my fault)
