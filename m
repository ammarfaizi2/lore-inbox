Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750734AbVHUXbB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750734AbVHUXbB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Aug 2005 19:31:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751133AbVHUXbB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Aug 2005 19:31:01 -0400
Received: from rain.plan9.de ([193.108.181.162]:10928 "EHLO rain.plan9.de")
	by vger.kernel.org with ESMTP id S1750734AbVHUXbA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Aug 2005 19:31:00 -0400
Date: Mon, 22 Aug 2005 01:30:58 +0200
From: Marc Lehmann <schmorp@schmorp.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel BUG at "fs/exec.c":777
Message-ID: <20050821233058.GA5027@schmorp.de>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20050818021908.GA11047@schmorp.de> <20050821014945.52df641e.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050821014945.52df641e.akpm@osdl.org>
X-PGP: "1024D/DA743396 1999-01-26 Marc Alexander Lehmann <schmorp@schmorp.de>
       Key fingerprint = 475A FE9B D1D4 039E 01AC  C217 A1E8 0270 DA74 3396"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 21, 2005 at 01:49:45AM -0700, Andrew Morton <akpm@osdl.org> wrote:
> Marc Lehmann <schmorp@schmorp.de> wrote:
> >
> > If wanted, I can probably reproduce
> > that without the nvidia kernel module loaded.
> > 
> 
> Yes, please do that, thanks.

I tried a few times with booting into textmode (the X-server loads the
nvidia module) and running the oops script, and after the third try, I
get the oops again, but not afterwards (I kept running it on the same
machine).


-- 
                The choice of a
      -----==-     _GNU_
      ----==-- _       generation     Marc Lehmann
      ---==---(_)__  __ ____  __      pcg@goof.com
      --==---/ / _ \/ // /\ \/ /      http://schmorp.de/
      -=====/_/_//_/\_,_/ /_/\_\      XX11-RIPE
