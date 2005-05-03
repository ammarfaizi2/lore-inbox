Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261190AbVECQeO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261190AbVECQeO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 May 2005 12:34:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261297AbVECQeO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 May 2005 12:34:14 -0400
Received: from animx.eu.org ([216.98.75.249]:12424 "EHLO animx.eu.org")
	by vger.kernel.org with ESMTP id S261190AbVECQeJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 May 2005 12:34:09 -0400
Date: Tue, 3 May 2005 12:33:43 -0400
From: Wakko Warner <wakko@animx.eu.org>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: zImage on 2.6?
Message-ID: <20050503163343.GC11937@animx.eu.org>
Mail-Followup-To: "Randy.Dunlap" <rddunlap@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20050503012951.GA10459@animx.eu.org> <20050502193503.20e6ac6e.rddunlap@osdl.org> <20050503104503.GA11123@animx.eu.org> <20050503072626.3a3c7349.rddunlap@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050503072626.3a3c7349.rddunlap@osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy.Dunlap wrote:
> On Tue, 3 May 2005 06:45:03 -0400 Wakko Warner wrote:
> | > It's supported in arch/i386/Makefile (and some others).
> | > For i386, you'll need to disable enough (lots of) options to make the
> | > resulting output file small enough...
> | 
> | The resultant bzImage is ~760kb.  I compiled out everything I could, only
> | ram disk/initrd, and ext2 are compiled in.
> | 
> | If you'd like to see the .config, I'll send it up.
> 
> Are you saying that zImage still fails (image is too large?) ?

Yes, I do recall it says "System is 724k".  zImage failes.  bzImage says
724k as well and succeeds.

> I built one, but I wouldn't want to boot it.  :)
> It looks like you would need to put almost everything into
> an initrd to make it usable.

That was the idea in this.  Once I get my stuff the way I want it, I'll
probably move on to using initramfs.  My initrd is using ramdisk, my / is on
tmpfs and is populated by .tgz files on other media (The boot time is
generally short lived by design anyway)

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
