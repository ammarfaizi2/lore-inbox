Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263333AbTEIRDq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 13:03:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263338AbTEIRDq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 13:03:46 -0400
Received: from pizda.ninka.net ([216.101.162.242]:59539 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S263333AbTEIRDp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 13:03:45 -0400
Date: Fri, 09 May 2003 10:16:09 -0700 (PDT)
Message-Id: <20030509.101609.08347577.davem@redhat.com>
To: pavel@ucw.cz
Cc: arnd@arndb.de, linux-kernel@vger.kernel.org
Subject: Re: ioctl32_unregister_conversion & modules
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030509171155.GA1042@elf.ucw.cz>
References: <20030509152436.GA762@elf.ucw.cz>
	<1052496782.19951.3.camel@rth.ninka.net>
	<20030509171155.GA1042@elf.ucw.cz>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Pavel Machek <pavel@ucw.cz>
   Date: Fri, 9 May 2003 19:11:55 +0200
   
   So... Do you think moving common handlers from arch/*/ioctl32.c into
   fs/compat_ioctl.c would do the trick?

Yes.
