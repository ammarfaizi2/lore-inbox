Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270466AbTGNQSJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 12:18:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270467AbTGNQSI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 12:18:08 -0400
Received: from AMarseille-201-1-2-223.w193-253.abo.wanadoo.fr ([193.253.217.223]:22311
	"EHLO gaston") by vger.kernel.org with ESMTP id S270466AbTGNQSF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 12:18:05 -0400
Subject: Re: Linux 2.4.22-pre5
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Richard A Nelson <cowboy@vnet.ibm.com>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.55L.0307111935180.6016@freak.distro.conectiva>
References: <Pine.LNX.4.55L.0307111705090.5422@freak.distro.conectiva>
	 <Pine.LNX.4.56.0307111821080.7464@onqynaqf.yrkvatgba.voz.pbz>
	 <Pine.LNX.4.55L.0307111935180.6016@freak.distro.conectiva>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1058200354.515.20.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 14 Jul 2003 18:32:34 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-07-12 at 00:38, Marcelo Tosatti wrote:
> Ben?

bk fuckage on my side, here it is

#ifndef __LINUX_RADEONFB_H__
#define __LINUX_RADEONFB_H__

#include <asm/ioctl.h>
#include <asm/types.h>

#define ATY_RADEON_LCD_ON	0x00000001
#define ATY_RADEON_CRT_ON	0x00000002


#define FBIO_RADEON_GET_MIRROR	_IOR('@', 3, __u32)
#define FBIO_RADEON_SET_MIRROR	_IOW('@', 4, __u32)

#endif


