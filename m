Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270346AbTHBVMr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Aug 2003 17:12:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270375AbTHBVMr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Aug 2003 17:12:47 -0400
Received: from fw.osdl.org ([65.172.181.6]:16872 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S270346AbTHBVMq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Aug 2003 17:12:46 -0400
Message-ID: <32991.4.4.25.4.1059858764.squirrel@www.osdl.org>
Date: Sat, 2 Aug 2003 14:12:44 -0700 (PDT)
Subject: Re: .config in bzImage ?
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: <seanlkml@rogers.com>
In-Reply-To: <093901c35924$f3040ed0$7f0a0a0a@lappy7>
References: <093901c35924$f3040ed0$7f0a0a0a@lappy7>
X-Priority: 3
Importance: Normal
Cc: <linux-kernel@vger.kernel.org>
X-Mailer: SquirrelMail (version 1.2.11)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> There was some talk of the .config file being included
> within bzImage.  Did this ever happen?  If so, how
> does one extract the .config from the resulting image?

Alan sent my ikconfig patch to Linus a couple of days ago and it's
in 2.6.0-test-current ... except for the Kconfig part of it,
which Alan or I will send soon (if Alan hasn't already done so).

The full was (which is partially merged) is at
  http://developer.osdl.org/rddunlap/patches/ikconfig/ikconfig_260c.patch
It includes a script (extract-ikconfig) and a small C program
(binoffsets.c) that are used to extract the saved .config image.

The .config file is also available in /proc as a CONFIG option.

~Randy



