Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264455AbTLCAbX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Dec 2003 19:31:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264456AbTLCAbX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Dec 2003 19:31:23 -0500
Received: from mtaw4.prodigy.net ([64.164.98.52]:13229 "EHLO mtaw4.prodigy.net")
	by vger.kernel.org with ESMTP id S264455AbTLCAbV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Dec 2003 19:31:21 -0500
Date: Tue, 2 Dec 2003 16:31:06 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: Vince <fuzzy77@free.fr>, zwane@arm.linux.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: [kernel panic @ reboot] 2.6.0-test10-mm1
Message-ID: <20031203003106.GF4154@mis-mike-wstn.matchmail.com>
Mail-Followup-To: "Randy.Dunlap" <rddunlap@osdl.org>,
	Vince <fuzzy77@free.fr>, zwane@arm.linux.org.uk,
	linux-kernel@vger.kernel.org
References: <3FC4DA17.4000608@free.fr> <Pine.LNX.4.58.0311261213510.1683@montezuma.fsmlabs.com> <3FC4E42A.40906@free.fr> <Pine.LNX.4.58.0311261240210.1683@montezuma.fsmlabs.com> <3FC4E8C8.4070902@free.fr> <Pine.LNX.4.58.0311261305020.1683@montezuma.fsmlabs.com> <20031126233738.GD1566@mis-mike-wstn.matchmail.com> <3FC53A3B.50601@free.fr> <20031202160303.2af39da0.rddunlap@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031202160303.2af39da0.rddunlap@osdl.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 02, 2003 at 04:03:03PM -0800, Randy.Dunlap wrote:
> On Thu, 27 Nov 2003 00:41:47 +0100 Vince <fuzzy77@free.fr> wrote:
> 
> | Mike Fedyk wrote:
> | > Interesting.  It would be nice to have a boot option that halts the system
> | > after the first oops, instead of trying to continue.
> 
> You mean like the "panic_on_oops" sysctl??  (implemented in i386 & ppc64)

...

> From Vince:
> | It worked, but I had -- as expected -- to write the oops by hand.
> | (user request to Randy: would it be possible to have an option in 
> | kmsgdump to only write the first oops on floppy ???)
> 
> Um, could you elaborate on why you would want that?
> kmsgdump assumes that the entire floppy belongs to it, so there
> should be plenty of room for multiple oopsen (although I don't
> know what it does on disk-full....).
> 
> I plan to add support for > 32 KB log buf sizes, but that's all I have
> planned for now.

Wouldn't he only get the first oops on the diskette if he had the sysctl
mentioned above enabled?
