Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265811AbUAUBlF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 20:41:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265797AbUAUBlF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 20:41:05 -0500
Received: from fw.osdl.org ([65.172.181.6]:10931 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265811AbUAUBlB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 20:41:01 -0500
Date: Tue, 20 Jan 2004 17:41:27 -0800
From: Andrew Morton <akpm@osdl.org>
To: Thomas Molina <tmolina@cablespeed.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.1-mm5
Message-Id: <20040120174127.33789836.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0401202034440.9398@localhost.localdomain>
References: <Pine.LNX.4.58.0401201724190.9398@localhost.localdomain>
	<20040120163452.3f407cbd.akpm@osdl.org>
	<Pine.LNX.4.58.0401202034440.9398@localhost.localdomain>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Molina <tmolina@cablespeed.com> wrote:
>
> 
> 
> On Tue, 20 Jan 2004, Andrew Morton wrote:
> 
> > Do you have
> > 
> > 	alias char-major-162 raw
> > 
> > in /etc/modprobe.conf?
> > 
> > If you do, touching /dev/rawctl does indeed corretly autoload the module,
> > but it seems that script still complains for some reason.
> 
> You asked this for mm4.  I added that line and it didn't help.  Sorry.

heh, OK.

If you do

	sudo rmmod raw
	sudo raw

does raw.ko get reloaded?

