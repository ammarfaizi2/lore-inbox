Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266897AbUHURqJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266897AbUHURqJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Aug 2004 13:46:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267542AbUHURqJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Aug 2004 13:46:09 -0400
Received: from smtp.terra.es ([213.4.129.129]:16548 "EHLO tsmtp2.mail.isp")
	by vger.kernel.org with ESMTP id S266897AbUHURqA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Aug 2004 13:46:00 -0400
Date: Sat, 21 Aug 2004 19:44:57 +0200
From: Diego Calleja <diegocg@teleline.es>
To: John McGowan <jmcgowan@inch.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel 2.6.8.1: memory leak? cdrecord problem?
Message-Id: <20040821194457.38920e99.diegocg@teleline.es>
In-Reply-To: <20040821172646.GA8781@localhost.localdomain>
References: <20040821172646.GA8781@localhost.localdomain>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Sat, 21 Aug 2004 13:26:46 -0400 John McGowan <jmcgowan@inch.com> escribió:

> KERNEL 2.6.8.1: Memory leak? CDrecord problem?


Yes, there's a memory leak, you can try 2.6.8.1-mm3
or apply the fix yourself (I think it's this one:
http://kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.8.1/2.6.8.1-mm3/broken-out/bio_uncopy_user-mem-leak.patch )
