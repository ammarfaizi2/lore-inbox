Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263137AbTLQDhY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Dec 2003 22:37:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263260AbTLQDhY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Dec 2003 22:37:24 -0500
Received: from mail.bluebottle.com ([69.20.6.25]:55981 "EHLO mail.bluebottle")
	by vger.kernel.org with ESMTP id S263137AbTLQDhX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Dec 2003 22:37:23 -0500
Date: Wed, 17 Dec 2003 01:37:20 -0200 (BRST)
From: =?ISO-8859-1?Q?Fr=E9d=E9ric_L=2E_W=2E_Meunier?= <1@pervalidus.net>
X-X-Sender: fredlwm@pervalidus.dyndns.org
To: linux-kernel@vger.kernel.org
Subject: CONFIG_UNIX98_PTY_COUNT and devfs
Message-ID: <Pine.LNX.4.58.0312170131500.397@pervalidus.dyndns.org>
X-Archive: encrypt
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I used CONFIG_UNIX98_PTY_COUNT=32 and it created
/dev/pty/m[0-255]. Is there any way to make devfs only create
/dev/pty/m[0-31] ?

>From Configure.help:

"When not in use, each additional set of 256 PTYs occupy
approximately 8 KB of kernel memory on 32-bit architectures."

Does that mean it doesn't make any difference if I set
CONFIG_UNIX98_PTY_COUNT=1 or CONFIG_UNIX98_PTY_COUNT=256, and
ONFIG_UNIX98_PTY_COUNT=257 will create 512 entries ?

-- 
http://www.pervalidus.net/contact.html
