Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263171AbTGOFjQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 01:39:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262931AbTGOFhx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 01:37:53 -0400
Received: from research.suspicious.org ([198.78.65.136]:37392 "EHLO
	research.suspicious.org") by vger.kernel.org with ESMTP
	id S262710AbTGOFhl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 01:37:41 -0400
Date: Tue, 15 Jul 2003 01:52:26 -0500
From: phil <phil@research.suspicious.org>
To: linux-kernel@vger.kernel.org
Subject: matroxfb driver
Message-Id: <20030715015226.679a7e6e.phil@research.suspicious.org>
Organization: research.suspicious.org
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


attempting to compile produces this error in 2.6.0-test1

drivers/built-in.o(.text+0x75340): In function `matroxfb_set_par':
: undefined reference to `default_grn'
drivers/built-in.o(.text+0x75345): In function `matroxfb_set_par':
: undefined reference to `default_blu'
drivers/built-in.o(.text+0x75353): In function `matroxfb_set_par':
: undefined reference to `color_table'
drivers/built-in.o(.text+0x7535b): In function `matroxfb_set_par':
: undefined reference to `default_red'
make: *** [.tmp_vmlinux1] Error 1


