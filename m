Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261951AbUB2ABb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Feb 2004 19:01:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261952AbUB2ABb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Feb 2004 19:01:31 -0500
Received: from gate.crashing.org ([63.228.1.57]:37309 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261951AbUB2ABa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Feb 2004 19:01:30 -0500
Subject: Re: Dropping CONFIG_PM_DISK?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: Andrew Morton <akpm@zip.com.au>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@osdl.org>
In-Reply-To: <20040228230039.GA246@elf.ucw.cz>
References: <20040228230039.GA246@elf.ucw.cz>
Content-Type: text/plain
Message-Id: <1078012320.906.9.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sun, 29 Feb 2004 10:52:01 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-02-29 at 10:00, Pavel Machek wrote:
> Hi!
> 
> Would there be any major screaming if I tried to drop CONFIG_PM_DISK?
> It seems noone is maintaining it, equivalent functionality is provided
> by swsusp, and it is confusing users...

Except that pmdisk code is +/- readable, swsusp is not...

Ben.


