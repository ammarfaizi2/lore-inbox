Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261556AbUBYXJX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 18:09:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261572AbUBYXHs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 18:07:48 -0500
Received: from fed1mtao01.cox.net ([68.6.19.244]:31886 "EHLO
	fed1mtao01.cox.net") by vger.kernel.org with ESMTP id S261556AbUBYXED
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 18:04:03 -0500
Date: Wed, 25 Feb 2004 16:04:02 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: George Anzinger <george@mvista.com>
Cc: kernel list <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@suse.cz>,
       "Amit S. Kale" <amitkale@emsyssoft.com>,
       kgdb-bugreport@lists.sourceforge.net
Subject: Re: [Kgdb-bugreport] [PATCH][2/3] Update CVS KGDB's have kgdb_{schedule,process}_breakpoint
Message-ID: <20040225230402.GM1052@smtp.west.cox.net>
References: <20040225213626.GF1052@smtp.west.cox.net> <20040225214343.GG1052@smtp.west.cox.net> <403D28E5.1060701@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <403D28E5.1060701@mvista.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 25, 2004 at 02:59:49PM -0800, George Anzinger wrote:

> If you are always inserting after irq_exit(), why not modify irq_exit()?  
> Makes a cleaner patch.

irq_exit() is in <asm/hardirq.h>, so it doesn't buy us anything in terms
of files modified.

-- 
Tom Rini
http://gate.crashing.org/~trini/
