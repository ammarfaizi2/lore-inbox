Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317669AbSFLIVM>; Wed, 12 Jun 2002 04:21:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317668AbSFLIVL>; Wed, 12 Jun 2002 04:21:11 -0400
Received: from vti01.vertis.nl ([145.66.4.26]:7433 "EHLO vti01.vertis.nl")
	by vger.kernel.org with ESMTP id <S317669AbSFLIVK>;
	Wed, 12 Jun 2002 04:21:10 -0400
Date: Wed, 12 Jun 2002 10:20:30 +0200
From: Rolf Fokkens <fokkensr@linux06.vertis.nl>
Message-Id: <200206120820.g5C8KUl13877@linux06.vertis.nl>
To: linux-kernel@vger.kernel.org
Subject: [BUG] [2.4.19-pre10] pcilynx doesn't compile
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When chosen as a module pcilynx.c doesn't compile:
pcilynx.c: In function `mem_open':
pcilynx.c:647: `num_of_cards' undeclared (first use in this function)
pcilynx.c:647: (Each undeclared identifier is reported only once
pcilynx.c:647: for each function it appears in.)
pcilynx.c:647: `cards' undeclared (first use in this function)
pcilynx.c: In function `aux_poll':
pcilynx.c:706: `cards' undeclared (first use in this function)
