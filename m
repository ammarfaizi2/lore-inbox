Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261829AbULCArM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261829AbULCArM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 19:47:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261826AbULCArM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 19:47:12 -0500
Received: from fw.osdl.org ([65.172.181.6]:28558 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261829AbULCAqD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 19:46:03 -0500
Date: Thu, 2 Dec 2004 16:45:59 -0800
From: Stephen Hemminger <shemminger@osdl.org>
To: Zoltan NAGY <nagyz@nefty.hu>
Cc: linux-kernel@vger.kernel.org, bridge@osdl.org
Subject: Re: IPv6 bridging
Message-Id: <20041202164559.429d90e8@dxpl.pdx.osdl.net>
In-Reply-To: <41AF57D7.10608@nefty.hu>
References: <41AF57D7.10608@nefty.hu>
Organization: Open Source Development Lab
X-Mailer: Sylpheed version 0.9.10claws (GTK+ 1.2.10; x86_64-suse-linux)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 02 Dec 2004 18:58:47 +0100
Zoltan NAGY <nagyz@nefty.hu> wrote:

> Hello!
> 
> Is it possible to bridge ip tunnels (IPv6 in IPv4)? brctl gives me an 
> error "Invalid argument",
> and from strace it seems it misses some ioctls from kernel...

That is because the bridge code works at the Ethernet level.
It is an 802 Ethernet bridge, not an IP tunnel.


> any ideas?
> 
> I need it to be able to give my UMLs a public ipv6 address.
> 
> Regrads,
> 
> Zoltan NAGY,
> Software Engineer
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
