Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262714AbTIVBUY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Sep 2003 21:20:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262715AbTIVBUY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Sep 2003 21:20:24 -0400
Received: from pizda.ninka.net ([216.101.162.242]:58568 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S262714AbTIVBUX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Sep 2003 21:20:23 -0400
Date: Sun, 21 Sep 2003 18:07:40 -0700
From: "David S. Miller" <davem@redhat.com>
To: Vinay K Nallamothu <vinay.nallamothu@gsecone.com>
Cc: netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.0-test5][NETROM] timer code cleanup
Message-Id: <20030921180740.0051dd30.davem@redhat.com>
In-Reply-To: <1064145739.4349.28.camel@lima.royalchallenge.com>
References: <1064145739.4349.28.camel@lima.royalchallenge.com>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 21 Sep 2003 17:32:19 +0530
Vinay K Nallamothu <vinay.nallamothu@gsecone.com> wrote:

> 1. move timer initialization into nr_init_timers so that we can use mod_timer
> 2. remove skb queue purge in af_netrom as its already done by nr_clear_queues
> 3. Use del_timer_sync in nr_loopback_clear

Looks good, applied.
