Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030597AbWAGVtu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030597AbWAGVtu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 16:49:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030599AbWAGVtu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 16:49:50 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:52998 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1030597AbWAGVtt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 16:49:49 -0500
Date: Sat, 7 Jan 2006 22:49:47 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Mark Fasheh <mark.fasheh@oracle.com>
Cc: kurt.hackel@oracle.com, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] OCFS2: __init / __exit problem
Message-ID: <20060107214947.GW3774@stusta.de>
References: <20060107132008.GE820@lug-owl.de> <20060107190702.GT3774@stusta.de> <20060107213821.GD3313@ca-server1.us.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060107213821.GD3313@ca-server1.us.oracle.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 07, 2006 at 01:38:21PM -0800, Mark Fasheh wrote:
> On Sat, Jan 07, 2006 at 08:07:02PM +0100, Adrian Bunk wrote:
> > It's a real problem that due to the fact that these errors have become 
> > runtime errors on i386 in kernel 2.6, we do no longer have a big testing 
> > coverage for them.  :-(
> Indeed. Those function declarations have been in there for a while,
> without any issue until now. Thanks for the patch Adrian.

The runtime error on architectures like i386 occurs in the error path of 
ocfs2_init().

This is the common problem that such error paths are only used once 
every dozen years and therefore get no real testing coverage...

> 	--Mark

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

