Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264498AbRFOTv4>; Fri, 15 Jun 2001 15:51:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264500AbRFOTvq>; Fri, 15 Jun 2001 15:51:46 -0400
Received: from avocet.mail.pas.earthlink.net ([207.217.121.50]:34466 "EHLO
	avocet.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S264498AbRFOTve>; Fri, 15 Jun 2001 15:51:34 -0400
Message-ID: <3B2A67EF.EE0A6677@earthlink.net>
Date: Fri, 15 Jun 2001 14:54:23 -0500
From: Kelledin Tane <runesong@earthlink.net>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: drivers/usb/ov511.c does not compile
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Apologies if this has been posted before.  I imagine it has.

In kernel 2.4.5 stock, ov511.c fails to compile.  A little intelligent
searching through 2.4.4 source reveals that the following line in 2.4.4:

static const char version[] = "1.28";

is missing in 2.4.5, and this is why it does not compile.  While I could
fix this myself manually (and plan to do so), it would be nice to get
the developer's blessing on this, and also nice to know exactly what
version number to give this driver in 2.4.5 stock.

