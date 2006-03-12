Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932106AbWCLKlO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932106AbWCLKlO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Mar 2006 05:41:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932110AbWCLKlN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Mar 2006 05:41:13 -0500
Received: from main.gmane.org ([80.91.229.2]:16336 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932106AbWCLKlL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Mar 2006 05:41:11 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Michal Feix <michal@feix.cz>
Subject: Re: KERNEL: assertion =?utf-8?b?KCFzay0+c2tfZm9yd2FyZF9hbGxvYyk=?= failed
Date: Sun, 12 Mar 2006 10:30:39 +0000 (UTC)
Message-ID: <loom.20060312T112407-724@post.gmane.org>
References: <cbec11ac0602091125w5a5a7c6em8462131e9f9b24dc@mail.gmail.com> <43EB98B0.4@kernelpanic.ru> <cbec11ac0602091137p4ee233bdgdcfbf3d6cb62a62f@mail.gmail.com> <20060310.025912.107001339.davem@davemloft.net> <Pine.LNX.4.64.0603101650390.11559@bizon.gios.gov.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 88.101.86.158 (Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050920 Firefox/1.0.7)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> So it must be another problem: I had this message with 2.6.15.2:
> 
> KERNEL: assertion (!sk->sk_forward_alloc) failed at net/core/stream.c (279)
> KERNEL: assertion (!sk->sk_forward_alloc) failed at net/ipv4/af_inet.c (148)
> 

Confirmed in 2.6.15.6. Exactly the same assertion in kern.log from time to time
on all my boxes with this kernel. Previous posts mentioned possible relevance
with e1000 ethernet card. Well, all these boxes has e1000 too, which probably
means nothing.

--
Michal Feix


