Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263897AbTJEWEi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Oct 2003 18:04:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263899AbTJEWEi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Oct 2003 18:04:38 -0400
Received: from [193.138.115.2] ([193.138.115.2]:39179 "HELO
	diftmgw.backbone.dif.dk") by vger.kernel.org with SMTP
	id S263897AbTJEWEg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Oct 2003 18:04:36 -0400
Date: Mon, 6 Oct 2003 00:03:42 +0200 (CEST)
From: Jesper Juhl <jju@dif.dk>
To: linux-kernel@vger.kernel.org
Subject: How come the assembler can't count? (probably insignificant, but
 0x37ffffff truncated to 0x37ffffff seems strange) 
Message-ID: <Pine.LNX.4.56.0310052356590.25637@jju_lnx.backbone.dif.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is probably completely insignificant, but I'm wondering why I get
warnings like the following when compiling 2.6.0-test* kernels :

tmp/cc211T0f.s: Assembler messages:
/tmp/cc211T0f.s:860: Warning: value 0x37ffffff truncated to 0x37ffffff

It seems like the assembler can't count since it seems to believe that
truncating a value to the same exact value would make a difference...
I've been trying to find the reason for this message, but so far I've not
been able to locate it. Does someone have an explanation for this
seemingly bogus warning?


/Jesper Juhl


