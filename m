Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318292AbSHEDfk>; Sun, 4 Aug 2002 23:35:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318293AbSHEDfk>; Sun, 4 Aug 2002 23:35:40 -0400
Received: from 205-158-62-132.outblaze.com ([205.158.62.132]:59876 "HELO
	ws5-2.us4.outblaze.com") by vger.kernel.org with SMTP
	id <S318292AbSHEDfk>; Sun, 4 Aug 2002 23:35:40 -0400
Message-ID: <20020805033909.4477.qmail@operamail.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Malcolm Smith " <msmith@operamail.com>
To: linux-kernel@vger.kernel.org
Date: Mon, 05 Aug 2002 11:39:09 +0800
Subject: 2.4.19 framebuffer issues?
X-Originating-Ip: 128.250.106.132
X-Originating-Server: ws5-2.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Has anybody else had any issues with 2.4.19 fb code?

I've found:
1. Displays everything 1cm to the right (compared to 2.4.18) - annoying, but ok

2. fbset doesn't work correctly - asking the kernel to change modes gives errors.

3. Related, X won't work on it.

3 is particularly concerning - it fails to resolve calls to shadowAdd (and two other shadowxxx calls.)  Works fine on 2.4.18.  I can't find these calls being exported from either kernel, or in the X source tree, and recompiling X on 2.4.19 didn't solve anything.

Also, I don't think my driver (SiS) is working right - the vga and vesa drivers seem to, but from memory, compiling a kernel with sis alone runs in text mode.

Can anybody shed any light on these problems?
Thanks in advance,
- Malcolm
-- 
_______________________________________________
Download the free Opera browser at http://www.opera.com/

Free OperaMail at http://www.operamail.com/

Powered by Outblaze
