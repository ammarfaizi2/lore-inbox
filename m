Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135618AbRDTChD>; Thu, 19 Apr 2001 22:37:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135783AbRDTCgw>; Thu, 19 Apr 2001 22:36:52 -0400
Received: from atlrel2.hp.com ([156.153.255.202]:38348 "HELO atlrel2.hp.com")
	by vger.kernel.org with SMTP id <S135618AbRDTCgk>;
	Thu, 19 Apr 2001 22:36:40 -0400
Date: Thu, 19 Apr 2001 20:36:39 -0600
To: esr@thyrsus.com
Cc: linux-kernel@vger.kernel.org, parisc-linux@parisc-linux.org
Subject: Re: OK, let's try cleaning up another nit. Is anyone paying attention?
Message-ID: <20010419203639.H4217@zumpano.fc.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
From: willy@ldl.fc.hp.com (Matthew Wilcox)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 19, 2001 at 18:50:34 EDT, Eric S. Raymond wrote:
> Remove dead CONFIG_BINFMT_JAVA symbol.

Please don't do this, it just makes merging our patches with Linus harder.
This has already been done in our tree since Feb 1.  In fact, please
don't touch anything in the tree which is PA specific; we have a large
arch update pending.

http://puffin.external.hp.com/cvs/linux/arch/parisc/config.in?log=y

shows the current state of our config.in, if you're curious.  If you
have any changes you want to make, don't hesitate to coordinate with us
by mailing parisc-linux@parisc-linux.org.

