Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267344AbUJBIR2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267344AbUJBIR2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Oct 2004 04:17:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267354AbUJBIR2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Oct 2004 04:17:28 -0400
Received: from postfix4-2.free.fr ([213.228.0.176]:57238 "EHLO
	postfix4-2.free.fr") by vger.kernel.org with ESMTP id S267344AbUJBIR1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Oct 2004 04:17:27 -0400
From: Duncan Sands <baldrick@free.fr>
To: "David S. Miller" <davem@davemloft.net>
Subject: Re: Oops at __neigh_for_each_release (2.6.9-rc3)
Date: Sat, 2 Oct 2004 09:58:00 +0200
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com, laforge@gnumonks.org
References: <200410012217.35264.baldrick@free.fr> <20041001135636.0c071602.davem@davemloft.net>
In-Reply-To: <20041001135636.0c071602.davem@davemloft.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200410020958.01197.baldrick@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > EIP is at __neigh_for_each_release+0x32/0xb0
> 
> Give this patch a try.  And please report networking bugs
> to netdev@oss.sgi.com in the future, thanks.

OK, will do.  I tested the patch Linus committed - it indeed fixes
the oops.

Thanks a lot!

Duncan.
