Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261425AbUFDOys@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261425AbUFDOys (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 10:54:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265795AbUFDOyr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 10:54:47 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:14606 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S261425AbUFDOyp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 10:54:45 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Dominik Karall <dominik.karall@gmx.net>, Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.7-rc2-mm2
Date: Fri, 4 Jun 2004 16:53:08 +0300
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
References: <20040603015356.709813e9.akpm@osdl.org> <200406031703.38722.dominik.karall@gmx.net>
In-Reply-To: <200406031703.38722.dominik.karall@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200406041653.09088.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 03 June 2004 18:03, Dominik Karall wrote:
> On Thursday 03 June 2004 10:53, Andrew Morton wrote:
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.7-rc2/2
> >.6 .7-rc2-mm2/
>
> SiS framebuffer works here. But my kernel does not boot, it stops at
>
> Starting hotplug subsystem:
>    input
>    net
>    pci
>      sis900: already loaded
>      8139too: already loaded
>      ignore pci display device on 01:00.0
>    usb
>
> and right here it stops.

Does not look like kernel messages to me.
If this happend after init is started, it's easy to track
which startup script/program hangs and run strace/gdb/whatever
on it.
--
vda

