Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315943AbSFYVzH>; Tue, 25 Jun 2002 17:55:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315946AbSFYVzG>; Tue, 25 Jun 2002 17:55:06 -0400
Received: from vti01.vertis.nl ([145.66.4.26]:29444 "EHLO vti01.vertis.nl")
	by vger.kernel.org with ESMTP id <S315943AbSFYVzF>;
	Tue, 25 Jun 2002 17:55:05 -0400
Date: Tue, 25 Jun 2002 23:54:15 +0200
From: Rolf Fokkens <fokkensr@linux06.vertis.nl>
Message-Id: <200206252154.g5PLsFG11517@linux06.vertis.nl>
To: linux-kernel@vger.kernel.org
Subject: [BUG] [2.4.19-rc1] w9966 doesn't compile
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

While trying to compile 2.4.19-rc1 the following error occurs:

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
