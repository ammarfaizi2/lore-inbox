Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262624AbVDYPsc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262624AbVDYPsc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 11:48:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262628AbVDYPrD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 11:47:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:33967 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S262635AbVDYPfq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 11:35:46 -0400
Date: Mon, 25 Apr 2005 17:35:41 +0200
From: Andi Kleen <ak@suse.de>
To: Patrick McHardy <kaber@trash.net>
Cc: Ed Tomlinson <tomlins@cam.org>, Alexander Nyberg <alexn@dsv.su.se>,
       Parag Warudkar <kernel-stuff@comcast.net>, linux-kernel@vger.kernel.org,
       ak@suse.de
Subject: Re: X86_64: 2.6.12-rc3 spontaneous reboot
Message-ID: <20050425153541.GC16828@wotan.suse.de>
References: <200504240008.35435.kernel-stuff@comcast.net> <1114332119.916.1.camel@localhost.localdomain> <200504240903.31377.tomlins@cam.org> <426CADF1.2000100@trash.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <426CADF1.2000100@trash.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25, 2005 at 10:44:33AM +0200, Patrick McHardy wrote:
> Ed Tomlinson wrote:
> >I think rc3 has code from rc2-mm2/3.  Both of these reboot here randomly.  
> >Nothing
> >shows up on a serial console...  Think something is seriously wrong with 
> >x86_64 in rc3.
> >That being said its possible its fixed in HEAD by.
> >
> >[PATCH] x86_64: fix new out of line put_user()
> >[PATCH] x86_64: Bug in new out of line put_user()
> 
> I'm seeing the same problem with a fresh git checkout when running uml
> or gcc in 32bit mode. Nothing is received from netconsole. If anyone
> can suggest which patches might be worth reverting I'll try that.

Well, you can revert all my x86-64 changes for testing that went
in after rc2. Does that make a difference? If yes then please
do a binary search or give me a test case that shows the problem.

-Andi
