Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265177AbUAYTFY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jan 2004 14:05:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265179AbUAYTFY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jan 2004 14:05:24 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:42763 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S265177AbUAYTFU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jan 2004 14:05:20 -0500
Date: Sun, 25 Jan 2004 20:11:06 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: Lista Linux-Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: mpspec.h, mach_mpspec.h
Message-ID: <20040125191106.GA3203@mars.ravnborg.org>
Mail-Followup-To: "J.A. Magallon" <jamagallon@able.es>,
	Lista Linux-Kernel <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>
References: <20040125172904.GA3195@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040125172904.GA3195@werewolf.able.es>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> Workaround is to add -I/usr/src/linux/include/asm/mach-default.

i386 at least always include:
-Iinclude/asm-i386/mach-default
Which should let gcc include the file in question.

Try to compile with V=1 and post the full command line to gcc.

	Sam
