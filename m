Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261152AbUAUAdf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 19:33:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265913AbUAUAdf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 19:33:35 -0500
Received: from fw.osdl.org ([65.172.181.6]:50567 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261152AbUAUAdd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 19:33:33 -0500
Date: Tue, 20 Jan 2004 16:34:52 -0800
From: Andrew Morton <akpm@osdl.org>
To: Thomas Molina <tmolina@cablespeed.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.1-mm5
Message-Id: <20040120163452.3f407cbd.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0401201724190.9398@localhost.localdomain>
References: <Pine.LNX.4.58.0401201724190.9398@localhost.localdomain>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Molina <tmolina@cablespeed.com> wrote:
>
> I am getting the following error messages:
> 
> Cannot open master raw device '/dev/rawctl' (No such device)

grr.  Something changed.

Do you have

	alias char-major-162 raw

in /etc/modprobe.conf?

If you do, touching /dev/rawctl does indeed corretly autoload the module,
but it seems that script still complains for some reason.


