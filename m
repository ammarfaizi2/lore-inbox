Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288956AbSAFOJh>; Sun, 6 Jan 2002 09:09:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288957AbSAFOJ0>; Sun, 6 Jan 2002 09:09:26 -0500
Received: from pizda.ninka.net ([216.101.162.242]:2450 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S288956AbSAFOJX>;
	Sun, 6 Jan 2002 09:09:23 -0500
Date: Sun, 06 Jan 2002 06:08:24 -0800 (PST)
Message-Id: <20020106.060824.106263786.davem@redhat.com>
To: davej@suse.de
Cc: anton@samba.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Remove 8 bytes from struct page on 64bit archs
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.33.0201061403120.3859-100000@Appserv.suse.de>
In-Reply-To: <20020106123913.GA5407@krispykreme>
	<Pine.LNX.4.33.0201061403120.3859-100000@Appserv.suse.de>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Dave Jones <davej@suse.de>
   Date: Sun, 6 Jan 2002 14:07:05 +0100 (CET)
   
   Some of the low end single zone machines (m68k, sparc32, arm etc)
   could benefit from losing ->virtual too.

Sparc32 has kmapping, so it would need virtual.
