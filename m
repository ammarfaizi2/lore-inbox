Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262648AbTI1SMX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Sep 2003 14:12:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262649AbTI1SMX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Sep 2003 14:12:23 -0400
Received: from MAIL.13thfloor.at ([212.16.62.51]:1721 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S262648AbTI1SMW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Sep 2003 14:12:22 -0400
Date: Sun, 28 Sep 2003 20:12:21 +0200
From: Herbert Poetzl <herbert@13thfloor.at>
To: linux-kernel@vger.kernel.org
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Multimode IDE in Linux ...
Message-ID: <20030928181221.GA11981@DUK2.13thfloor.at>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Alan Cox <alan@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi All!

maybe somebody can explain the following:

using the QEMU emulator, I discovered (by looking at
error messages ;) that the 2.6.0-test6 (and probably
earlier kernels too) issue a SETMULTI (multimode)
command regardless of the CONFIG_IDEDISK_MULTI_MODE
setting. this isn't the case in 2.4.23-pre5 ...

I had a look at the command issued, and found that
it tries to set 256 sectors multimode, so I assume
this is some multimode magic, I do not understand.

TIA,
Herbert

