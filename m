Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267574AbTAXG7J>; Fri, 24 Jan 2003 01:59:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267573AbTAXG7J>; Fri, 24 Jan 2003 01:59:09 -0500
Received: from samar.sasken.com ([164.164.56.2]:29572 "EHLO samar.sasken.com")
	by vger.kernel.org with ESMTP id <S267574AbTAXG7I>;
	Fri, 24 Jan 2003 01:59:08 -0500
Date: Fri, 24 Jan 2003 12:38:08 +0530 (IST)
From: Madhavi <madhavis@sasken.com>
To: <linux-kernel@vger.kernel.org>
Subject: Stack overflow
Message-ID: <Pine.LNX.4.33.0301241232590.3655-100000@pcz-madhavis.sasken.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi

I am testing a PCI network device driver on linux-2.4.19.

I have observed a peculiar problem during testing.

I have a functionality which works well if the code whcih performs this
function is embedded in the required function. If this functionality is
implemented as a separate function, and this function is called at the
required place, the system crashes. I have used KDB for debugging. But,
KDB also fails when this system crash occurs.

Could this be because of any function stack overflow? I am new to this
field. Could someone through some light on this.

Thanks in advacne.

regards
Madhavi.

