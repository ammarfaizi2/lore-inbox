Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271381AbTG2Jxr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 05:53:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271369AbTG2JxO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 05:53:14 -0400
Received: from violet.setuza.cz ([194.149.118.97]:12051 "EHLO violet.setuza.cz")
	by vger.kernel.org with ESMTP id S271371AbTG2Jvs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 05:51:48 -0400
Subject: Simple module question
From: Frank =?ISO-8859-1?Q?Sch=E4fer?= <Frank.Schafer@setuza.cz>
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 29 Jul 2003 11:56:33 +0200
Message-Id: <1059472604.1109.6.camel@ADMIN.setuza.cz>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi list,

We have a monolithic kernel 2.4.18 using ip-tables. The ftp contrack
module takes a optional parameter port=xxxxx.

This parameter should be puttable by the kernel parameters. So I put it
on the addons line in lilo.conf.

The parameter doesn't show up in the boot dmesg, I can see it in
/proc/cmdline, but it doesn't seem to work. No ftp connection can be
made on this port.

Could anzbody put me a hint?

Thanks in advance
Frank


