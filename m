Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265043AbSJRH7Q>; Fri, 18 Oct 2002 03:59:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265057AbSJRH7Q>; Fri, 18 Oct 2002 03:59:16 -0400
Received: from pizda.ninka.net ([216.101.162.242]:32964 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S265050AbSJRH7P>;
	Fri, 18 Oct 2002 03:59:15 -0400
Date: Fri, 18 Oct 2002 00:57:35 -0700 (PDT)
Message-Id: <20021018.005735.11577937.davem@redhat.com>
To: crispin@wirex.com
Cc: greg@kroah.com, hch@infradead.org, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org, linux-security-module@wirex.com
Subject: Re: [PATCH] remove sys_security
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3DAFBFA2.4040207@wirex.com>
References: <20021017205830.GD592@kroah.com>
	<20021017.135832.54206778.davem@redhat.com>
	<3DAFBFA2.4040207@wirex.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Crispin Cowan <crispin@wirex.com>
   Date: Fri, 18 Oct 2002 01:00:34 -0700

   LSM is not zero-footprint, but it is as low as we could make it.

I disagree, entirely.

You could entirely hide a lot of this crap, especially the
VFS stuff, by stacking in your own LSM specific VFS ops
if we could stack filesystems or something like that.
