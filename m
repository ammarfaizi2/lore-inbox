Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751045AbVHVUZE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751045AbVHVUZE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 16:25:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751055AbVHVUZE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 16:25:04 -0400
Received: from smtp.osdl.org ([65.172.181.4]:36060 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751041AbVHVUZC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 16:25:02 -0400
Date: Mon, 22 Aug 2005 13:23:33 -0700
From: Andrew Morton <akpm@osdl.org>
To: Dave Jones <davej@redhat.com>
Cc: jgarzik@pobox.com, linux-kernel@vger.kernel.org, mlindner@syskonnect.de
Subject: Re: skge missing ifdefs.
Message-Id: <20050822132333.2ff893e6.akpm@osdl.org>
In-Reply-To: <20050822195913.GF27344@redhat.com>
References: <20050801203442.GD2473@redhat.com>
	<20050801203818.GA7497@havoc.gtf.org>
	<20050822195913.GF27344@redhat.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones <davej@redhat.com> wrote:
>
> On Mon, Aug 01, 2005 at 04:38:18PM -0400, Jeff Garzik wrote:
>  > On Mon, Aug 01, 2005 at 04:34:42PM -0400, Dave Jones wrote:
>  > > with CONFIG_PM undefined, the build breaks due to 
>  > > undefined symbols.
>  > 
>  > akpm already sent a fix to Linus.
> 
> This is still broken afaics in todays -git.
> 

Works for me.  CONFIG_PM=n, CONFIG_SKGE=y or m, CONFIG_SK98LIN=y or m.

btw, is one of the recent `%td' fans going to, like, implement it in
printk()?
