Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264811AbUDWNwe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264811AbUDWNwe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Apr 2004 09:52:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264816AbUDWNwd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Apr 2004 09:52:33 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:4737 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S264811AbUDWNwW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Apr 2004 09:52:22 -0400
Date: Fri, 23 Apr 2004 22:52:13 +0900
From: Keiichiro Tokunaga <tokunaga.keiich@jp.fujitsu.com>
Subject: Re: [Pcihpd-discuss] [RFC] New sysfs tree for hotplug
In-reply-to: <20040423123057.GE22558@parcelfarce.linux.theplanet.co.uk>
To: Matthew Wilcox <willy@debian.org>
Cc: tokunaga.keiich@jp.fujitsu.com, linux-kernel@vger.kernel.org
Message-id: <20040423225213.2d589e40.tokunaga.keiich@jp.fujitsu.com>
Organization: FUJITSU LIMITED
MIME-version: 1.0
X-Mailer: Sylpheed version 0.9.9 (GTK+ 1.2.10; i686-pc-linux-gnu)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
References: <20040415170939.0ff62618.tokunaga.keiich@jp.fujitsu.com>
 <20040416223436.GB21701@kroah.com>
 <20040423211816.152dc326.tokunaga.keiich@jp.fujitsu.com>
 <20040423123057.GE22558@parcelfarce.linux.theplanet.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Apr 2004 13:30:57 +0100
Matthew Wilcox <willy@debian.org> wrote:

> On Fri, Apr 23, 2004 at 09:18:16PM +0900, Keiichiro Tokunaga wrote:
> > That's right.  /sys/devices/hotplug/ACPI/ tree becomes hard-wired one.  I was
> > thinking to define the board by using ACPI (as a "generic container device" in
> > ACPI namespace).  Therefore, if there is the new tree I proposed in the kernel,
> > it would be easy to represent the hierarchy, and a directory for the board
> > appears in the new tree.  So I thought that we could put an control file to
> > invoke the board hotplug and an information file under the directory.
> > (Actually, I've made a rough patch for the new tree and it seems to work fine:)
> > I also thought that interface for hotplug could be unified so that it would become
> > easier for user to use.
> 
> Have you seen Alex Williamson's patch to fill out the /sys/firmware/acpi tree?
> http://marc.theaimsgroup.com/?l=linux-kernel&m=108239031314885&w=2

Yes, I have.  I understand he's trying to expose objects and control methods
under /sys/firmware/acpi/namespace/ACPI/ tree and user can access it.  Actually,
I'm interested in hotplug part he mentioned and wondering if it's possible to
run _EJ0 method without any hotplug processing.  That's what I know so far,
since I didn't know he has already relased the new patch.  Thanks for the
information, I'll take a look at that :)

I'm sorry for the crossposting.  I just wanted to hear from every hotplug related
people as possible...  Now I'm sending this to you and lkml.

Thanks,
Kei
