Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261203AbVGTNUK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261203AbVGTNUK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Jul 2005 09:20:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261206AbVGTNUK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Jul 2005 09:20:10 -0400
Received: from dtp.xs4all.nl ([80.126.206.180]:9791 "HELO abra2.bitwizard.nl")
	by vger.kernel.org with SMTP id S261203AbVGTNUI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Jul 2005 09:20:08 -0400
Date: Wed, 20 Jul 2005 15:20:07 +0200
From: Erik Mouw <erik@harddisk-recovery.com>
To: Bastiaan Naber <naber@inl.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: a 15 GB file on tmpfs
Message-ID: <20050720132006.GI7050@harddisk-recovery.com>
References: <200507201416.36155.naber@inl.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200507201416.36155.naber@inl.nl>
Organization: Harddisk-recovery.com
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 20, 2005 at 02:16:36PM +0200, Bastiaan Naber wrote:
> I have a 15 GB file which I want to place in memory via tmpfs. I want to do 
> this because I need to have this data accessible with a very low seek time.

That should be no problem on a 64 bit architecture.

> I want to know if this is possible before spending 10,000 euros on a machine 
> that has 16 GB of memory. 

If you want to spend that amount of money on memory anyway, the extra
cost for an AMD64 machine isn't that large.

> The machine we plan to buy is a HP Proliant Xeon machine and I want to run a 
> 32 bit linux kernel on it (the xeon we want doesn't have the 64-bit stuff 
> yet)

AFAIK you can't use a 15 GB tmpfs on i386 because large memory support
is basically a hack to support multiple 4GB memory spaces (some VM guru
correct me if I'm wrong). Just get an Athlon64 machine and run a 64 bit
kernel on it. If compatibility is a problem, you can still run a 32 bit
i386 userland on an x86_64 kernel.


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
