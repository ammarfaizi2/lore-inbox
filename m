Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274893AbTHPRl4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Aug 2003 13:41:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274897AbTHPRl4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Aug 2003 13:41:56 -0400
Received: from fw.osdl.org ([65.172.181.6]:12931 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S274893AbTHPRlz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Aug 2003 13:41:55 -0400
Message-ID: <32980.4.4.25.4.1061055714.squirrel@www.osdl.org>
Date: Sat, 16 Aug 2003 10:41:54 -0700 (PDT)
Subject: Re: increased verbosity in dmesg
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: <gene.heskett@verizon.net>
In-Reply-To: <200308161136.01133.gene.heskett@verizon.net>
References: <200308160438.59489.gene.heskett@verizon.net>
        <1061031726.623.3.camel@teapot.felipe-alfaro.com>
        <200308161136.01133.gene.heskett@verizon.net>
X-Priority: 3
Importance: Normal
Cc: <felipe_alfaro@linuxmail.org>, <linux-kernel@vger.kernel.org>
X-Mailer: SquirrelMail (version 1.2.11)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Which says that a setting of 15 would get 32k then.
> I take it this (for an i386 system) is the correct file to edit?
>
> kernel/ikconfig.h:CONFIG_LOG_BUF_SHIFT=14 \n\
> Mmmm, that says do not edit, auto-generated, so how about this one?
>
> include/config/log/buf/shift.h
>
> which contains only that single line.  Its now 15 & we'll see.

No, you don't edit either of those files.
You use 'make *config' or you edit .config and then
run make oldconfig.

~Randy



