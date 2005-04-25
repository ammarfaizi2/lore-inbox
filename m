Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262700AbVDYSPH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262700AbVDYSPH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 14:15:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262702AbVDYSPH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 14:15:07 -0400
Received: from mailfe06.swip.net ([212.247.154.161]:2282 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S262700AbVDYSPC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 14:15:02 -0400
X-T2-Posting-ID: jLUmkBjoqvly7NM6d2gdCg==
Subject: Re: X86_64: 2.6.12-rc3 spontaneous reboot
From: Alexander Nyberg <alexn@dsv.su.se>
To: Andi Kleen <ak@suse.de>
Cc: Patrick McHardy <kaber@trash.net>, Ed Tomlinson <tomlins@cam.org>,
       Parag Warudkar <kernel-stuff@comcast.net>, linux-kernel@vger.kernel.org
In-Reply-To: <20050425153541.GC16828@wotan.suse.de>
References: <200504240008.35435.kernel-stuff@comcast.net>
	 <1114332119.916.1.camel@localhost.localdomain>
	 <200504240903.31377.tomlins@cam.org> <426CADF1.2000100@trash.net>
	 <20050425153541.GC16828@wotan.suse.de>
Content-Type: text/plain
Date: Mon, 25 Apr 2005 20:14:59 +0200
Message-Id: <1114452899.2012.2.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > >I think rc3 has code from rc2-mm2/3.  Both of these reboot here randomly.  
> > >Nothing
> > >shows up on a serial console...  Think something is seriously wrong with 
> > >x86_64 in rc3.
> > >That being said its possible its fixed in HEAD by.
> > >
> > >[PATCH] x86_64: fix new out of line put_user()
> > >[PATCH] x86_64: Bug in new out of line put_user()
> > 
> > I'm seeing the same problem with a fresh git checkout when running uml
> > or gcc in 32bit mode. Nothing is received from netconsole. If anyone
> > can suggest which patches might be worth reverting I'll try that.
> 
> Well, you can revert all my x86-64 changes for testing that went
> in after rc2. Does that make a difference? If yes then please
> do a binary search or give me a test case that shows the problem.
> 

Usually gives in after about 20 minutes of gcc compiling, sometimes even
up to 40 minutes. I had 2.6.12-rc2 stand for 2-3 hours so it seems ok.
If anyone has a better recipe for it please do tell.

It doesn't appear to be any of the obvious patch candidates...

