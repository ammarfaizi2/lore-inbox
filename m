Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262709AbVENIwz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262709AbVENIwz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 May 2005 04:52:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262710AbVENIwz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 May 2005 04:52:55 -0400
Received: from fire.osdl.org ([65.172.181.4]:25807 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262709AbVENIwy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 May 2005 04:52:54 -0400
Date: Sat, 14 May 2005 01:52:10 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Joseph A. Yasi" <yasij@rpi.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: scheduling while atomic 2.6.12-rc4-mm1
Message-Id: <20050514015210.764aad82.akpm@osdl.org>
In-Reply-To: <200505140259.45746.yasij@rpi.edu>
References: <200505140259.45746.yasij@rpi.edu>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Joseph A. Yasi" <yasij@rpi.edu> wrote:
>
> During the mount of my reiser4 root filesystem on boot with 2.6.12-rc4-mm1 I 
>  get a scheduling while atomic.

Yes, reiser4 is borked in rc4-mm1.  Please revert

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12-rc4/2.6.12-rc4-mm1/broken-out/reiser4-sb_sync_inodes-cleanup.patch
