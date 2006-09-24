Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752100AbWIXEBi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752100AbWIXEBi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 00:01:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752105AbWIXEBi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 00:01:38 -0400
Received: from smtp.osdl.org ([65.172.181.4]:64224 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1752100AbWIXEBf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 00:01:35 -0400
Date: Sat, 23 Sep 2006 21:01:12 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: Joerg Roedel <joro-lkml@zlug.org>
Cc: Patrick McHardy <kaber@trash.net>, davem@davemloft.net,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 02/03] net/bridge: add support for EtherIP devices
Message-ID: <20060923210112.130938ca@localhost.localdomain>
In-Reply-To: <20060923121629.GC32284@zlug.org>
References: <20060923120704.GA32284@zlug.org>
	<20060923121629.GC32284@zlug.org>
X-Mailer: Sylpheed-Claws 2.4.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Sep 2006 14:16:29 +0200
Joerg Roedel <joro-lkml@zlug.org> wrote:

> This patch changes the device check in the bridge code to allow EtherIP
> devices to be added.
> 
> Signed-off-by: Joerg Roedel <joro-lkml@zlug.org>

If the device looks like a duck (Ethernet), then why does it need
a separate ARP type.  There are other tools that might work without
modification if it just fully pretended to be an ether device.
