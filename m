Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262201AbUKDMdh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262201AbUKDMdh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 07:33:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262207AbUKDMcd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 07:32:33 -0500
Received: from sd291.sivit.org ([194.146.225.122]:61404 "EHLO sd291.sivit.org")
	by vger.kernel.org with ESMTP id S262201AbUKDMcB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 07:32:01 -0500
Date: Thu, 4 Nov 2004 13:32:11 +0100
From: Stelian Pop <stelian@popies.net>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Christoph Hellwig <hch@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 7/12] meye: the driver is no longer experimental and depends on PCI
Message-ID: <20041104123210.GW3472@crusoe.alcove-fr>
Reply-To: Stelian Pop <stelian@popies.net>
Mail-Followup-To: Stelian Pop <stelian@popies.net>,
	Arjan van de Ven <arjan@infradead.org>,
	Christoph Hellwig <hch@infradead.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
References: <20041104111231.GF3472@crusoe.alcove-fr> <20041104111613.GM3472@crusoe.alcove-fr> <20041104114126.GA31736@infradead.org> <20041104114904.GV3472@crusoe.alcove-fr> <1099570980.16640.6.camel@laptop.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1099570980.16640.6.camel@laptop.fenrus.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 04, 2004 at 01:23:00PM +0100, Arjan van de Ven wrote:

> 
> > Of course, the actual hardware does exist only on C1V* Vaio Laptops,
> > which can accept at most 256 MB RAM
> 
> 
> ... but distros enable PAE anyway for things like NX and for general
> reasons (distros need to support > 4Gb ram of course ;)

On a Fedora Core 2:
	$ grep HIGHMEM /boot/config-2.6.6-1.435 
	# CONFIG_NOHIGHMEM is not set
	CONFIG_HIGHMEM4G=y
	# CONFIG_HIGHMEM64G is not set
	CONFIG_HIGHMEM=y
	# CONFIG_DEBUG_HIGHMEM is not set

I thought that CONFIG_HIGHMEM64G is not cost-free and thus must
be enabled only when needed...

Stelian.
-- 
Stelian Pop <stelian@popies.net>    
