Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263370AbUASCnd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jan 2004 21:43:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264284AbUASCnd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jan 2004 21:43:33 -0500
Received: from fw.osdl.org ([65.172.181.6]:36535 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263370AbUASCna (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jan 2004 21:43:30 -0500
Date: Sun, 18 Jan 2004 18:39:28 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Charles Shannon Hendrix <shannon@widomaker.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: xscreensaver and kernel 2.6.x
Message-Id: <20040118183928.00dde600.rddunlap@osdl.org>
In-Reply-To: <20040118235728.GF9456@widomaker.com>
References: <20040118235728.GF9456@widomaker.com>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 18 Jan 2004 18:57:28 -0500 Charles Shannon Hendrix <shannon@widomaker.com> wrote:

| 
| 
| I'm trying to find the details on why xscreensaver has some troubles
| with the 2.6 kernels.
| 
| On my system, something in pam is failing, causing a several seconds
| delay when unlocking my screen.
| 
| In /var/log/messages, I get this:
| 
| Jan 18 17:59:07 daydream xscreensaver(pam_unix)[869]: authentication
| failure; logname= uid=1000 euid=1000 tty=:0.0 ruser= rhost= user=shannon
| Jan 18 17:59:09 daydream xscreensaver(pam_unix)[869]: authentication
| failure; logname= uid=1000 euid=1000 tty=:0.0 ruser= rhost=  user=root
| 
| This happens with all 2.6 kernels, and all earlier kernels work fine.
| 
| I found a lot of references to problems with pam and the 2.5 and 2.6
| kernels, but can't seem to find the details I want.
| 
| Any help appreciated.
| 
| I don't get lockups, but the delay is annoying, and I hate broken
| things.

There are patches in Red Hat 9 (pam) for this, and someone else
pointed to the location of pam package fixes for it, but I don't
have that pointer around... sorry.

--
~Randy
Everything is relative.
