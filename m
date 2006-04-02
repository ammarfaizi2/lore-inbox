Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932340AbWDBOBb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932340AbWDBOBb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Apr 2006 10:01:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932343AbWDBOBb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Apr 2006 10:01:31 -0400
Received: from ns1.suse.de ([195.135.220.2]:19914 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932340AbWDBOBa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Apr 2006 10:01:30 -0400
Date: Sun, 2 Apr 2006 16:01:29 +0200
From: Olaf Hering <olh@suse.de>
To: John Mylchreest <johnm@gentoo.org>
Cc: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       stable@kernel.org, paulus@samba.org
Subject: Re: [PATCH 1/1] POWERPC: Fix ppc32 compile with gcc+SSP in 2.6.16
Message-ID: <20060402140129.GA31403@suse.de>
References: <20060401224849.GH16917@getafix.willow.local> <20060402085850.GA28857@suse.de> <20060402102259.GM16917@getafix.willow.local> <20060402102815.GA29717@suse.de> <20060402105859.GN16917@getafix.willow.local> <20060402111002.GA30017@suse.de> <20060402112002.GA3443@getafix.willow.local> <1143983738.2994.18.camel@laptopd505.fenrus.org> <20060402135605.GB3443@getafix.willow.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20060402135605.GB3443@getafix.willow.local>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Sun, Apr 02, John Mylchreest wrote:

> It gets turned on elsewhere (gcc spec), but principle for me is that if its
> enabled it still leaks and breaks this code. At the moment (following
> from existing patches you put to this list) this mix will break until we
> get stack-protector ported.

There are so many ebuild files which turn off random gcc options without
fixing the real bug in the compiler. Just add one more to the
kernel.ebuild or whatever its called.
