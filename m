Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268748AbTGOQdw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 12:33:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268790AbTGOQdw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 12:33:52 -0400
Received: from 12-240-128-156.client.attbi.com ([12.240.128.156]:56029 "EHLO
	carlthompson.net") by vger.kernel.org with ESMTP id S268748AbTGOQdt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 12:33:49 -0400
Message-ID: <1058287708.48b29132da9b9@carlthompson.net>
X-Priority: 3 (Normal)
Date: Tue, 15 Jul 2003 09:48:28 -0700
From: Carl Thompson <cet@carlthompson.net>
To: Martin Zwickel <martin.zwickel@technotrend.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Problems compiling modules outside of tree in 2.6.0test1
References: <1058251587.eec14da73ec3b@carlthompson.net>
	<20030715104006.79c58435.martin.zwickel@technotrend.de>
In-Reply-To: <20030715104006.79c58435.martin.zwickel@technotrend.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
User-Agent: Internet Messaging Program (IMP) 4.0-cvs
X-Originating-IP: 192.168.0.163
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Martin Zwickel <martin.zwickel@technotrend.de>:

> On Mon, 14 Jul 2003 23:46:27 -0700
> Carl Thompson <cet@carlthompson.net> bubbled:
>
> What about:
>
> CFLAGS += -I/usr/include/asm/mach-default/

This is what I'm doing now.  But this is architecture specific.  On some
i386 architectures you might want "include/asm/mach-voyager" or
"include/asm/mach-visws" instead.  I don't think I should have to keep
track of architecture specific include paths when the kernel build system
already does that for me.  The correct files should automatically be found
when included by kernel headers, in my opinion.  Or there out to be a
"include/asm/mach-platform" which is handled like "include/asm" as a
symbolic link which is made by the build system.

> Martin Zwickel <martin.zwickel@technotrend.de>

Carl Thompson


