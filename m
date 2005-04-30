Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261216AbVD3NZx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261216AbVD3NZx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Apr 2005 09:25:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261218AbVD3NZw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Apr 2005 09:25:52 -0400
Received: from mailfe01.swip.net ([212.247.154.1]:53149 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S261216AbVD3NZt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Apr 2005 09:25:49 -0400
X-T2-Posting-ID: jLUmkBjoqvly7NM6d2gdCg==
Subject: Re: 2.6.12-rc3-mm1
From: Alexander Nyberg <alexn@dsv.su.se>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, shaohua.li@intel.com
In-Reply-To: <20050429231653.32d2f091.akpm@osdl.org>
References: <20050429231653.32d2f091.akpm@osdl.org>
Content-Type: text/plain
Date: Sat, 30 Apr 2005 15:25:39 +0200
Message-Id: <1114867539.872.35.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> - We're still miles away from 2.6.12.  Lots of patches here, plus my
>   collection of bugs-post-2.6.11 is vast.  I'll start working through them
>   again after 2.6.12-rc4 is available to testers.
> 

sep-initializing-rework.patch doesn't even call sysenter_setup() on UP
boxes so it'll break the vsyscall instantly. This cannot even have been
boot-tested on UP...

http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12-rc3/2.6.12-rc3-mm1/broken-out/sep-initializing-rework.patch

