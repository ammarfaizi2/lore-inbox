Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132681AbRDBK4Q>; Mon, 2 Apr 2001 06:56:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132682AbRDBK4H>; Mon, 2 Apr 2001 06:56:07 -0400
Received: from mailout03.sul.t-online.com ([194.25.134.81]:50960 "EHLO
	mailout03.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S132680AbRDBKzx>; Mon, 2 Apr 2001 06:55:53 -0400
Content-Type: text/plain; charset=US-ASCII
From: Wolfgang Rohdewald <WRohdewald@dplanet.ch>
Reply-To: WRohdewald@dplanet.ch
To: linux-ibcs2@vger.kernel.org
Subject: 2.2.19 breaks iBCS2: Patch
Date: Mon, 2 Apr 2001 11:55:41 +0200
X-Mailer: KMail [version 1.2.1]
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010402095543.AEEF0400D2@poboxes.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

in 2.2.19, linux/include/asm-i386/uaccess.h is missing the line

#define strlen_user(str) strnlen_user(str, ~0UL >> 1)

putting it back makes iBCS2 work again.

Btw will iBCS2 ever be ported to the 2.4 kernel? I'm stuck with 2.2
until this is ported.

Please CC: me, I'm not (yet) subscribed

Thanks, Wolfgang
