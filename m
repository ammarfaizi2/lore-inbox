Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751633AbWBWGwV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751633AbWBWGwV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 01:52:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751634AbWBWGwV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 01:52:21 -0500
Received: from xenotime.net ([66.160.160.81]:20671 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751632AbWBWGwV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 01:52:21 -0500
Date: Wed, 22 Feb 2006 22:53:25 -0800
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: "Alexander E. Patrakov" <patrakov@ums.usu.ru>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc4-mm1
Message-Id: <20060222225325.10a71472.rdunlap@xenotime.net>
In-Reply-To: <43FC6B8F.4060601@ums.usu.ru>
References: <20060220042615.5af1bddc.akpm@osdl.org>
	<43FC6B8F.4060601@ums.usu.ru>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Feb 2006 18:47:59 +0500 Alexander E. Patrakov wrote:

> Andrew Morton wrote:
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc4/2.6.16-rc4-mm1/
> plus hotfixes
> 
> Unfortunately, I lost my .config from the old kernel, so I attempted the 
> following:
> 
> cd scripts
> make binoffset
> cd ..
> scripts/extract-ikconfig /boot/vmlinuz-2.6.16-rc3-mm1-home >.config
> 
> This results in:
> 
> zcat: stdin: decompression OK, trailing garbage ignored

No other output?  what $ARCH?
What did the .config file contain?  was it correct?
so is the only problem the zcat warning message?

I tested extract-ikconfig several times without errors (on 2.6.16-rc4-mm1).

---
~Randy
