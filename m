Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262441AbTI0NEy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Sep 2003 09:04:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262439AbTI0NEx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Sep 2003 09:04:53 -0400
Received: from path.emicnetworks.com ([194.137.152.194]:55441 "EHLO mail.emic")
	by vger.kernel.org with ESMTP id S262438AbTI0NEw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Sep 2003 09:04:52 -0400
Date: Sat, 27 Sep 2003 16:04:45 +0300
From: "Alexey V. Yurchenko" <ayurchen@mail.emicnetworks.com>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: linux-net@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: how to set multicast MAC ligitemately?
Message-Id: <20030927160445.6ff09796.ayurchen@mail.emicnetworks.com>
In-Reply-To: <20030926120345.6668d96f.shemminger@osdl.org>
References: <20030926215326.23f7de24.ayurchen@mail.emicnetworks.com>
	<20030926120345.6668d96f.shemminger@osdl.org>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Sep 2003 12:03:45 -0700
Stephen Hemminger <shemminger@osdl.org> wrote:

> 
> Not interface should have a multicast MAC address. A multicast address
> should only exist as a destination address, never a source.

Well, that's in theory. In practice I need several computers connected to a switch to share a single interface and look to the rest of LAN as a single node. All those computers must receive all packets desitned to that interface. Using non-multicast MAC confuses many switches.

Any suggestions? (Except not using a switch ;))

Regards,
Alex

PS isn't this approach (forbidding certain addresses) a tad Microsoftish? Like saving users from themselves? If
