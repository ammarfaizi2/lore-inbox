Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932472AbVJCXut@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932472AbVJCXut (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 19:50:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932726AbVJCXut
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 19:50:49 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:65494
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932724AbVJCXus (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 19:50:48 -0400
Date: Mon, 03 Oct 2005 16:50:46 -0700 (PDT)
Message-Id: <20051003.165046.126193591.davem@davemloft.net>
To: jmacbaine@gmail.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: 2.6.13 crash on sparc64 in sunsu_kbd_ms_interrupt
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <3afbacad050831085155914ef6@mail.gmail.com>
References: <3afbacad050831085155914ef6@mail.gmail.com>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Please turn off CONFIG_PREEMPT on sparc64, it really doesn't
get very much testing on this platform.
