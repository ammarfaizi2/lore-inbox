Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316542AbSFPUaD>; Sun, 16 Jun 2002 16:30:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316544AbSFPUaC>; Sun, 16 Jun 2002 16:30:02 -0400
Received: from vti01.vertis.nl ([145.66.4.26]:32523 "EHLO vti01.vertis.nl")
	by vger.kernel.org with ESMTP id <S316542AbSFPUaB>;
	Sun, 16 Jun 2002 16:30:01 -0400
Date: Sun, 16 Jun 2002 09:01:16 +0200
From: Rolf Fokkens <fokkensr@linux06.vertis.nl>
Message-Id: <200206160701.g5G71Ge11878@linux06.vertis.nl>
To: linux-kernel@vger.kernel.org
Subject: [BUG] [2.4.19-pre10] w9966 doesn't compile
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

While trying to compile 2.4.19pre10 the following error occurs:

w9966.c:68: warning: invalid character in macro parameter name
w9966.c:68: badly punctuated parameter list in `#define'
w9966.c:69: warning: invalid character in macro parameter name
w9966.c:69: badly punctuated parameter list in `#define'
w9966.c: In function `w9966_init':
w9966.c:329: warning: implicit declaration of function `DPRINTF'
w9966.c: In function `w9966_setup':
w9966.c:432: warning: implicit declaration of function `DASSERT'

Relevant config options seem to me:

CONFIG_VIDEO_W9966=m

Cheers,

Rolf
