Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263742AbUAHFSM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 00:18:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263760AbUAHFSM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 00:18:12 -0500
Received: from fw.osdl.org ([65.172.181.6]:54169 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263742AbUAHFSJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 00:18:09 -0500
Date: Wed, 7 Jan 2004 21:15:21 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: "Silk Thadeum" <thadeum@hotmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: /drivers/net/tulip/dmfe.c may be outdated : kernel loading
 problem
Message-Id: <20040107211521.467dd421.rddunlap@osdl.org>
In-Reply-To: <Sea2-F38LFQG101s7hp0000e306@hotmail.com>
References: <Sea2-F38LFQG101s7hp0000e306@hotmail.com>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 08 Jan 2004 05:41:17 +0100 "Silk Thadeum" <thadeum@hotmail.com> wrote:

| Hello,
| 
| I have been working on Linux 2.4.20 for a couple of months and use a Davicom 
| Semiconductor Ethernet network card driver known as dmfe.c for module dmfe.
| 
| I had no problem since here, but on Linux 2.6.0-i386-stable kernel is 
| refusing to load the module :
| 
| --
| $ insmod dmfe.o
| insmod: error inserting 'dmfe.o': -1 Invalid module format
| $ lspci | grep Davicom
| 00:0a.0 Ethernet controller : Davicom Semiconductor, Inc. Ethernet 100/10 
| Mbit (rev 31)
| --

In Linux 2.6.x, you load modules with names like 'dmfe.ko'.
And be sure to use module-init-tools, not modutils.
The module-init-tools location is listed in the Documentation/Changes
file.

| 
| I tried to load the module by various ways : with old (for 2.4.20) and new 
| (from 2.6.0 stable) compiled driver, but that didn't work. I quickly looked 
| at the source code which seems quite old. I can't actually help you in 
| having a deeper workaround because I don't yet have sufficient technical 
| skills for that.

Are you building the module for 2.6.x in the norm(al) way
or using some homebrew commands or script?

| I'm working on a Debian Sarge testing prerelease.
| 
| Have fun in debug ;p

of course ;)

--
~Randy
MOTD:  Always include version info.
