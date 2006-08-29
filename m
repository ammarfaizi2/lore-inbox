Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932257AbWH2J1J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932257AbWH2J1J (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 05:27:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932254AbWH2J1J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 05:27:09 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:59589
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932228AbWH2J1H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 05:27:07 -0400
Date: Tue, 29 Aug 2006 02:26:35 -0700 (PDT)
Message-Id: <20060829.022635.08324656.davem@davemloft.net>
To: miles.lane@gmail.com
Cc: akpm@osdl.org, dcbw@redhat.com, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, jeremy@goop.org, rml@novell.com
Subject: Re: 2.6.18-rc4-mm[1,2,3] -- Network card not getting assigned an
 "eth" device name
From: David Miller <davem@davemloft.net>
In-Reply-To: <a44ae5cd0608290143m3ad300eej5b325270c9d57b66@mail.gmail.com>
References: <20060828120328.ae734de0.akpm@osdl.org>
	<20060828.132717.57158097.davem@davemloft.net>
	<a44ae5cd0608290143m3ad300eej5b325270c9d57b66@mail.gmail.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-2022-jp-2
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Miles Lane" <miles.lane@gmail.com>
Date: Tue, 29 Aug 2006 01:43:48 -0700

> Then, when I testing running NetworkManager.bak, I got:
> 
> [NetworkManager.:6078]: Changing netdevice name from [eth1] to [`$,3u=(B$,3u=(B]
> [NetworkManager.:6078]: Changing netdevice name from [eth0] to [`$,3u=(B$,3u=(B]

Someone who can debug NetworkManager with gdb or similar needs
to step through it and figure out why it wants to use this
crazy garbage string as the name.
