Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262239AbTDQUNs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Apr 2003 16:13:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262423AbTDQUNs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2003 16:13:48 -0400
Received: from air-2.osdl.org ([65.172.181.6]:14805 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262239AbTDQUNr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2003 16:13:47 -0400
Date: Thu, 17 Apr 2003 13:25:40 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: Andrew Morton <akpm@digeo.com>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [patch] Fix orlov allocator boundary case
Message-Id: <20030417132540.2602a2c5.shemminger@osdl.org>
In-Reply-To: <20030417122142.39d27f73.akpm@digeo.com>
References: <20030417111303.706d7246.shemminger@osdl.org>
	<20030417122142.39d27f73.akpm@digeo.com>
Organization: Open Source Development Lab
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Apr 2003 12:21:42 -0700
Andrew Morton <akpm@digeo.com> wrote:

> Stephen Hemminger <shemminger@osdl.org> wrote:
> >
> > Recent (post 2.5.67) versions of the kernel break the creation
> > of the initial ram disk.
> 
> OK, here be the fix.
> 
> I'm a bit peeved that this wasn't discovered until it hit Linus's tree. 
> Weren't these patches in -mjb as well?

The patch fixed the problem -- thanks again
