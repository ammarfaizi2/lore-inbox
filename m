Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261616AbVAXUUs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261616AbVAXUUs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 15:20:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261615AbVAXUTw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 15:19:52 -0500
Received: from wproxy.gmail.com ([64.233.184.205]:32004 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261616AbVAXURa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 15:17:30 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=QQB1iyCw1LPcRr8oZbG+gZMmszmUuSguysjgrB3WrZcq7oCa8r8F4xVaqjzr0pqobfo+AV84GFsAbrpyC1J/44z9M2eqFPnKig4IlEbowMt9hnmkk4GMVOkfXjns74+2CsdGN86JVyzZYet3NDEGZ36Z+HGDHs7siHPnooWo7Qk=
Message-ID: <f071747505012412171470901@mail.gmail.com>
Date: Mon, 24 Jan 2005 12:17:26 -0800
From: Aurash Mahbod <amahbod@gmail.com>
Reply-To: Aurash Mahbod <amahbod@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: 2.4.27-1-386 compiling 2.6.10 getting errors
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am compiling 2.6.10 and am getting crc errors.

lib/gen_crc32table.c:10: error: parse error before "crc32table_le"
lib/gen_crc32table.c:10: warning: type defaults to `int' in
declaration of `crc32table_le'
lib/gen_crc32table.c:10: warning: data definition has no type or storage class
lib/gen_crc32table.c:11: error: parse error before "crc32table_be"
lib/gen_crc32table.c:11: warning: type defaults to `int' in
declaration of `crc32table_be'
lib/gen_crc32table.c:11: warning: data definition has no type or storage class
lib/gen_crc32table.c: In function `crc32init_le':
lib/gen_crc32table.c:23: error: `uint32_t' undeclared (first use in
this function)
lib/gen_crc32table.c:23: error: (Each undeclared identifier is
reported only once
lib/gen_crc32table.c:23: error: for each function it appears in.)
lib/gen_crc32table.c:23: error: parse error before "crc"
lib/gen_crc32table.c:28: error: `crc' undeclared (first use in this function)
lib/gen_crc32table.c: In function `crc32init_be':
lib/gen_crc32table.c:40: error: `uint32_t' undeclared (first use in
this function)
lib/gen_crc32table.c:40: error: parse error before "crc"
lib/gen_crc32table.c:45: error: `crc' undeclared (first use in this function)
lib/gen_crc32table.c: At top level:
lib/gen_crc32table.c:51: error: parse error before "table"
lib/gen_crc32table.c:52: warning: function declaration isn't a prototype
lib/gen_crc32table.c: In function `output_table':
lib/gen_crc32table.c:55: error: `len' undeclared (first use in this function)
lib/gen_crc32table.c:58: error: `trans' undeclared (first use in this function)
lib/gen_crc32table.c:58: error: `table' undeclared (first use in this function)
make[2]: *** [lib/gen_crc32table] Error 1
make[1]: *** [lib] Error 2
make[1]: Leaving directory `/usr/src/linux-2.6.10'
make: *** [stamp-build] Error 2

Motherboard: Soyo Dragon Plus
CPU: Athlon XP 1800+
ram: 512MB PC2700
video card: nvidia GeForce 4 4400ti

thanks for the help!

-Aurash Mahbod
amahbod@gmail.com
