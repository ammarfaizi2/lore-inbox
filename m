Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262918AbTE0I6b (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 04:58:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262930AbTE0I6a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 04:58:30 -0400
Received: from pizda.ninka.net ([216.101.162.242]:50322 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S262918AbTE0I62 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 04:58:28 -0400
Date: Tue, 27 May 2003 02:10:58 -0700 (PDT)
Message-Id: <20030527.021058.91786451.davem@redhat.com>
To: arjanv@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: userspace irq balancer
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <1054026451.5301.2.camel@laptop.fenrus.com>
References: <20030527011620.GB7135@suse.de>
	<20030526.181734.68129361.davem@redhat.com>
	<1054026451.5301.2.camel@laptop.fenrus.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Arjan van de Ven <arjanv@redhat.com>
   Date: 27 May 2003 11:07:32 +0200
   
   I have a 2.4 patch to use the acpitimer for things like this. That
   (when present) provides accurate high frequency time info.

I don't expect many problems on the 2.5.x side (which is where I plan
on doing this) since x86 appears to have a driver-like architecture
to handle the various types of timers.
