Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1426063AbWLHSEs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1426063AbWLHSEs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Dec 2006 13:04:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1426061AbWLHSEs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 13:04:48 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:3650 "HELO
	mailout.stusta.mhn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1426063AbWLHSEq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 13:04:46 -0500
Date: Fri, 8 Dec 2006 19:04:55 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: UML and fastcall/FASTCALL
Message-ID: <20061208180455.GD3356@stusta.de>
References: <20061208125928.GA25427@stusta.de> <20061208163304.GA5944@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061208163304.GA5944@ccure.user-mode-linux.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 08, 2006 at 11:33:04AM -0500, Jeff Dike wrote:
> On Fri, Dec 08, 2006 at 01:59:28PM +0100, Adrian Bunk wrote:
> > UML on i386 is now the only case where fastcall/FASTCALL is not a noop.
> 
> If i386 doesn't use it any more, then UML shouldn't either.  The only reason
> there's support for it in UML is that I was copying i386.

It's a noop on i386 due to -mregparm=3 ...

> 				Jeff

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

