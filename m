Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262437AbUK3Xng@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262437AbUK3Xng (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 18:43:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262452AbUK3Xmf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 18:42:35 -0500
Received: from mail.kroah.org ([69.55.234.183]:9930 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262431AbUK3Xj1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 18:39:27 -0500
Date: Tue, 30 Nov 2004 15:36:41 -0800
From: Greg KH <greg@kroah.com>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Misleading error message
Message-ID: <20041130233641.GA26660@kroah.com>
References: <001101c4d715$25a59470$af00a8c0@BEBEL> <Pine.LNX.4.53.0411302151160.31175@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0411302151160.31175@yvahk01.tjqt.qr>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 30, 2004 at 09:56:25PM +0100, Jan Engelhardt wrote:
> >I compiled built-in support for iptables in my new 2.6.9 kernel, but when my
> >legacy firewall does a "modprobe ip_tables" , I get the startling message:
> >"FATAL: module ip_tables not found" .
> k
> 
> Linux Developers,
> 
> what would you think of say, a line added to modules' code that identifies
> compiled-in components?

See the patches posted to lkml to have modules that are built into the
kernel show up in sysfs.  Hopefully the remaining issues to that patch
are being addressed and then it will eventually make it into the main
kernel tree.  That should help with this issue a lot.

thanks,

greg k-h
