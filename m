Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965083AbWGFACh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965083AbWGFACh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 20:02:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965082AbWGFACg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 20:02:36 -0400
Received: from smtp.osdl.org ([65.172.181.4]:31945 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965083AbWGFACf convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 20:02:35 -0400
Date: Wed, 5 Jul 2006 17:02:28 -0700
From: Andrew Morton <akpm@osdl.org>
To: "J.A. =?ISO-8859-1?B?TWFnYWxs824i?= <jamagallon@ono.com>"@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-mm6
Message-Id: <20060705170228.9e595851.akpm@osdl.org>
In-Reply-To: <20060706015706.37acb9af@werewolf.auna.net>
References: <20060703030355.420c7155.akpm@osdl.org>
	<20060705234347.47ef2600@werewolf.auna.net>
	<20060705155602.6e0b4dce.akpm@osdl.org>
	<20060706015706.37acb9af@werewolf.auna.net>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Jul 2006 01:57:06 +0200
"J.A. Magallón" <jamagallon@ono.com> wrote:
>
> > > 
> > > With -mm6, the kernel doesn't find it. I get this on boot:
> > > 
> > > kinit: try_name sda,1 = dev(8,1)
> > > kinit: name_to_dev_t(/dev/sda1) = dev(8.1)
> > > kinit: root_dev = dev(8,1)
> > > kinit: failed to identify filesystem /dev/root, trying all
> > > kinit: trying to mount /dev/root on /root with type ext3
> > > kinit: Cannot open root device dev(8,1)
> > > 
> > > I have tried to get this message from -mm1, but could not get it in any log.
> > > But... I remember to see that the boot message is like:
> > > 
> > > kinit: try_name sda,1 = sda1(8,1)
> > >                         ^^^^
> > > I have verified I built -mm6 with ext3,sata-piix and so on, all builtin.
> > > 
> > 
> > Are you able to test just 2.6.17 + origin.patch + git-libata-all.patch?
> > 
> > Also, the full dmesg from 2.6.17-mm6 would help, thanks.
> > 
> 
> It does not reach a point to save the dmesg....
> I can pick my digital camera.

Full dmesg would be better for this one, please.

> Is there a netconsole version for OSX (to attach my ibook and dump dmesg...) ?

All you need is netcat.  google(netcat os-x) looks promising.
