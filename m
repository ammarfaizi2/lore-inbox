Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316158AbSFPLLy>; Sun, 16 Jun 2002 07:11:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316161AbSFPLLx>; Sun, 16 Jun 2002 07:11:53 -0400
Received: from vti01.vertis.nl ([145.66.4.26]:1284 "EHLO vti01.vertis.nl")
	by vger.kernel.org with ESMTP id <S316158AbSFPLLx>;
	Sun, 16 Jun 2002 07:11:53 -0400
Date: Sat, 15 Jun 2002 23:43:14 +0200
From: Rolf Fokkens <fokkensr@linux06.vertis.nl>
Message-Id: <200206152143.g5FLhEJ25954@linux06.vertis.nl>
To: linux-kernel@vger.kernel.org
Subject: [BUG] [2.4.19-pre10] pcilynx doesn't compile
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

While trying to compile 2.4.19 the following error occurs:

pcilynx.c: In function `mem_open':
pcilynx.c:647: `num_of_cards' undeclared (first use in this function)
pcilynx.c:647: (Each undeclared identifier is reported only once
pcilynx.c:647: for each function it appears in.)
pcilynx.c:647: `cards' undeclared (first use in this function)
pcilynx.c: In function `aux_poll':
pcilynx.c:706: `cards' undeclared (first use in this function)

Relevant config options seem to me:

CONFIG_IEEE1394_PCILYNX=m
CONFIG_IEEE1394_PCILYNX_LOCALRAM=y
CONFIG_IEEE1394_PCILYNX_PORTS=y

Cheers,

Rolf
