Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264342AbTDWX6E (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 19:58:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264343AbTDWX6E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 19:58:04 -0400
Received: from [12.47.58.232] ([12.47.58.232]:47803 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S264342AbTDWX6D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 19:58:03 -0400
Date: Wed, 23 Apr 2003 17:07:59 -0700
From: Andrew Morton <akpm@digeo.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: mbligh@aracnet.com, ncunningham@clear.net.nz, gigerstyle@gmx.ch,
       pavel@ucw.cz, geert@linux-m68k.org, linux-kernel@vger.kernel.org
Subject: Re: Fix SWSUSP & !SWAP
Message-Id: <20030423170759.2b4e6294.akpm@digeo.com>
In-Reply-To: <20030423235820.GB32577@atrey.karlin.mff.cuni.cz>
References: <1051136725.4439.5.camel@laptop-linux>
	<1584040000.1051140524@flay>
	<20030423235820.GB32577@atrey.karlin.mff.cuni.cz>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 24 Apr 2003 00:10:03.0534 (UTC) FILETIME=[DA94FAE0:01C309F5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@ucw.cz> wrote:
>
> If you really want to "solve" it reliably, you can always
> 
> swapon /dev/hdfoo666
> 

Seems that using a swapfile instead of a swapdev would fix that neatly.

But iirc, suspend doesn't work with swapfiles.  Is that correct?  If so,
what has to be done to get it working?

