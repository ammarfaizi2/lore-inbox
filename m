Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268457AbUH3Olm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268457AbUH3Olm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 10:41:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268447AbUH3Okr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 10:40:47 -0400
Received: from jade.spiritone.com ([216.99.193.136]:9394 "EHLO
	jade.spiritone.com") by vger.kernel.org with ESMTP id S268340AbUH3Ojt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 10:39:49 -0400
Date: Mon, 30 Aug 2004 07:39:42 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc1-mm1 can't compile a kernel
Message-ID: <123000000.1093876781@[10.10.2.4]>
In-Reply-To: <20040829202106.181784a3.akpm@osdl.org>
References: <114120000.1093830897@[10.10.2.4]> <20040829202106.181784a3.akpm@osdl.org>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Yes, rc1-mm1 does everything right apart from reading data from files.
> 
> Reverting 
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc1/2.6.9-rc1-mm1/broken-out/re-fix-pagecache-reading-off-by-one-cleanup.patch
> 
> then
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc1/2.6.9-rc1-mm1/broken-out/re-fix-pagecache-reading-off-by-one.patch
> 
> will help.

Works fine now.

Thanks,

M.

